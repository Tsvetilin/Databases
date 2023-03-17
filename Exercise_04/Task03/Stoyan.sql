--1. Напишете заявка, която извежда цялата налична информация за всеки
--кораб, включително и данните за неговия клас. В резултата не трябва да
--се включват тези класове, които нямат кораби.
SELECT *
FROM SHIPS
         JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS

--2. Повторете горната заявка, като този път включите в резултата и
--класовете, които нямат кораби, но съществуват кораби със същото име
--като тяхното.
SELECT *
FROM SHIPS
         FULL JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE CLASSES.CLASS IS NOT NULL OR CLASSES.CLASS IN (SELECT NAME FROM SHIPS)

--3. За всяка страна изведете имената на корабите, които никога не са
--участвали в битка.
SELECT CLASSES.COUNTRY, SHIPS.NAME
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
WHERE SHIPS.NAME NOT IN (SELECT SHIPS.NAME FROM OUTCOMES
                                                    JOIN SHIPS ON SHIPS.NAME = OUTCOMES.SHIP
                                                    JOIN BATTLES ON BATTLES.NAME = OUTCOMES.BATTLE)
ORDER BY CLASSES.COUNTRY, SHIPS.NAME

--4. Намерете имената на всички кораби с поне 7 оръдия, пуснати на вода
--през 1916, но наречете резултатната колона Ship Name.
SELECT SHIPS.NAME AS 'Ship Name'
FROM SHIPS
         JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE CLASSES.NUMGUNS >= 7 AND
        SHIPS.LAUNCHED = 1916

--5. Изведете имената на всички потънали в битка кораби, името и дата на
--провеждане на битките, в които те са потънали. Подредете резултата по
--име на битката.
SELECT SHIPS.NAME, BATTLES.NAME, BATTLES.DATE
FROM SHIPS
         JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
         JOIN BATTLES ON OUTCOMES.BATTLE = BATTLES.NAME
WHERE OUTCOMES.RESULT = 'sunk'
ORDER BY BATTLES.NAME

--6. Намерете името, водоизместимостта и годината на пускане на вода на
--всички кораби, които имат същото име като техния клас.
SELECT SHIPS.NAME, CLASSES.DISPLACEMENT, SHIPS.LAUNCHED
FROM SHIPS
         JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE SHIPS.NAME = CLASSES.CLASS

--7. Намерете всички класове кораби, от които няма пуснат на вода нито един
--кораб.
SELECT *
FROM CLASSES
WHERE CLASSES.CLASS NOT IN
      (SELECT CLASSES.CLASS
       FROM CLASSES JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS)

--8. Изведете името, водоизместимостта и броя оръдия на корабите,
--участвали в битката ‘North Atlantic’, а също и резултата от битката.
SELECT SHIPS.NAME, CLASSES.DISPLACEMENT, CLASSES.NUMGUNS, OUTCOMES.RESULT
FROM SHIPS JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
           JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
           JOIN BATTLES ON OUTCOMES.BATTLE = BATTLES.NAME
WHERE BATTLES.NAME = 'North Atlantic'