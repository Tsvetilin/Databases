--1. Напишете заявка, която извежда имената на всички кораби без повторения,
--които са участвали в поне една битка и чиито имена започват с C или K.
SELECT DISTINCT SHIPS.NAME
FROM SHIPS
         JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE SHIPS.NAME LIKE 'C%'
   OR SHIPS.NAME LIKE 'K%'

--2. Напишете заявка, която извежда име и държава на всички кораби, които
--никога не са потъвали в битка (може и да не са участвали).
SELECT DISTINCT SHIPS.NAME, CLASSES.COUNTRY
FROM SHIPS
         JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
         LEFT JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE RESULT != 'sunk' or RESULT IS NULL

--3. Напишете заявка, която извежда държавата и броя на потъналите кораби за
--тази държава. Държави, които нямат кораби или имат кораб, но той не е
--участвал в битка, също да бъдат изведени.
SELECT CLASSES.COUNTRY, COUNT(SHIP)
FROM SHIPS
         RIGHT JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
         LEFT JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE RESULT = 'sunk'
   or RESULT IS NULL
GROUP BY CLASSES.COUNTRY

--4. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи кораби) от битката при Guadalcanal.
SELECT OUTCOMES.BATTLE
FROM OUTCOMES
GROUP BY OUTCOMES.BATTLE
HAVING COUNT(SHIP) > (SELECT COUNT(SHIP) FROM OUTCOMES WHERE BATTLE = 'Guadalcanal' GROUP BY BATTLE)

--5. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи страни) от битката при Surigao Strait.
SELECT OUTCOMES.BATTLE
FROM (SELECT COUNTRY
      FROM OUTCOMES
               JOIN SHIPS ON OUTCOMES.SHIP = SHIPS.NAME
               JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
      WHERE BATTLE = 'Surigao Strait') AS t,
     OUTCOMES
         JOIN SHIPS ON OUTCOMES.SHIP = SHIPS.NAME
         JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY OUTCOMES.BATTLE
HAVING COUNT(CLASSES.COUNTRY) > COUNT(t.COUNTRY)

--6. Напишете заявка, която извежда имената на най-леките кораби с най-много
--оръдия.
SELECT SHIPS.NAME, CLASSES.DISPLACEMENT, CLASSES.NUMGUNS
FROM SHIPS
         JOIN CLASSES
              ON SHIPS.CLASS = CLASSES.CLASS
WHERE CLASSES.DISPLACEMENT <= ALL (SELECT CLASSES.DISPLACEMENT
                                   FROM CLASSES
                                            JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS)
  AND CLASSES.DISPLACEMENT >= ALL (SELECT CLASSES.NUMGUNS
                                   FROM CLASSES
                                            JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS)

--7. Изведете броя на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в друга битка.
SELECT COUNT(O.SHIP)
FROM OUTCOMES AS O
         JOIN BATTLES AS B
              ON O.BATTLE = B.NAME
GROUP BY O.SHIP, O.RESULT, B.DATE
HAVING O.RESULT = 'ok'
   AND B.DATE > (SELECT BATTLES.DATE
                 FROM OUTCOMES
                          JOIN BATTLES
                               ON OUTCOMES.BATTLE = BATTLES.NAME
                 WHERE OUTCOMES.SHIP = O.SHIP
                 GROUP BY OUTCOMES.SHIP, OUTCOMES.RESULT, BATTLES.DATE
                 HAVING OUTCOMES.RESULT = 'damaged')

--8. Изведете име на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в по-мащабна битка (с повече кораби).
SELECT O.SHIP
FROM OUTCOMES AS O
         JOIN BATTLES AS B
              ON O.BATTLE = B.NAME
GROUP BY O.SHIP, O.RESULT, B.DATE
HAVING O.RESULT = 'ok'
   AND B.DATE > (SELECT BATTLES.DATE
                 FROM OUTCOMES
                          JOIN BATTLES
                               ON OUTCOMES.BATTLE = BATTLES.NAME
                 WHERE OUTCOMES.SHIP = O.SHIP
                 GROUP BY OUTCOMES.SHIP, OUTCOMES.RESULT, BATTLES.DATE
                 HAVING OUTCOMES.RESULT = 'damaged')
   AND COUNT(O.SHIP) >= (SELECT COUNT(OUTCOMES.SHIP)
                         FROM OUTCOMES
                                  JOIN BATTLES
                                       ON OUTCOMES.BATTLE = BATTLES.NAME
                         WHERE OUTCOMES.SHIP = O.SHIP
                         GROUP BY OUTCOMES.SHIP, OUTCOMES.RESULT, BATTLES.DATE
                         HAVING OUTCOMES.RESULT = 'damaged')
