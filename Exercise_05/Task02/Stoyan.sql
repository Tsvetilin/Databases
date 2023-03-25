--1. Напишете заявка, която извежда броя на класовете бойни кораби.
SELECT COUNT(TYPE)
FROM CLASSES
WHERE TYPE = 'bb'

--2. Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.
SELECT CLASS, AVG(NUMGUNS) AS AvgGuns
FROM CLASSES
WHERE TYPE = 'bb'
GROUP BY CLASS

--3. Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.
SELECT AVG(NUMGUNS) AS AvgGuns
FROM CLASSES
WHERE TYPE = 'bb'

--4. Напишете заявка, която извежда за всеки клас първата и последната година, в
--която кораб от съответния клас е пуснат на вода.
SELECT CLASSES.CLASS, MIN(LAUNCHED) AS FirstYear, MAX(LAUNCHED) AS LastYear
FROM CLASSES JOIN SHIPS
                  ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY CLASSES.CLASS

--5. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа.
SELECT CLASSES.CLASS, COUNT(NAME)
FROM CLASSES JOIN SHIPS
                  ON CLASSES.CLASS = SHIPS.CLASS
             JOIN OUTCOMES ON
        OUTCOMES.SHIP = SHIPS.NAME
WHERE RESULT = 'sunk'
GROUP BY CLASSES.CLASS

--6. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа, за тези класове с повече от 2 кораба.
SELECT CLASSES.CLASS, COUNT(NAME)
FROM CLASSES JOIN SHIPS
                  ON CLASSES.CLASS = SHIPS.CLASS
             JOIN OUTCOMES ON
        OUTCOMES.SHIP = SHIPS.NAME
WHERE RESULT = 'sunk'
GROUP BY CLASSES.CLASS
HAVING CLASSES.CLASS IN
       (SELECT CLASSES.CLASS
        FROM CLASSES JOIN SHIPS
                          ON CLASSES.CLASS = SHIPS.CLASS
        GROUP BY CLASSES.CLASS
        HAVING COUNT(SHIPS.NAME) > 2)
        
#or

SELECT SHIPS.CLASS, COUNT(SHIPS.NAME)
FROM SHIPS JOIN OUTCOMES
ON SHIPS.NAME = OUTCOMES.SHIP
WHERE RESULT = 'sunk'
AND SHIPS.CLASS IN (SELECT CLASS FROM SHIPS GROUP BY CLASS HAVING COUNT(NAME) > 2)
GROUP BY SHIPS.CLASS

--7. Напишете заявка, която извежда средния калибър на оръдията на корабите за
--всяка страна.
SELECT AVG(BORE)
FROM SHIPS
         JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE SHIPS.NAME IN (SELECT SHIPS.NAME FROM SHIPS)
GROUP BY CLASSES.COUNTRY
