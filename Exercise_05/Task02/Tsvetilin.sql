--II. За базата от данни SHIPS
USE ships

--1. Напишете заявка, която извежда броя на класовете бойни кораби.
SELECT COUNT(DISTINCT dbo.CLASSES.CLASS)
FROM dbo.CLASSES
WHERE dbo.CLASSES.TYPE='bb'

--2. Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.
SELECT AVG(dbo.CLASSES.NUMGUNS), dbo.CLASSES.CLASS
FROM dbo.CLASSES
WHERE dbo.CLASSES.TYPE='bb'
GROUP BY dbo.CLASSES.CLASS

--3. Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.
SELECT AVG(dbo.CLASSES.NUMGUNS)
FROM dbo.CLASSES
WHERE dbo.CLASSES.TYPE='bb'

--4. Напишете заявка, която извежда за всеки клас първата и последната година, в която кораб от съответния клас е пуснат на вода.
SELECT MIN(dbo.SHIPS.LAUNCHED), MAX(dbo.SHIPS.LAUNCHED), dbo.SHIPS.CLASS
FROM dbo.SHIPS
GROUP BY dbo.SHIPS.CLASS

--5. Напишете заявка, която извежда броя на корабите, потънали в битка според класа.
SELECT COUNT(dbo.SHIPS.NAME), dbo.SHIPS.CLASS
FROM dbo.SHIPS JOIN dbo.OUTCOMES ON dbo.SHIPS.NAME=dbo.OUTCOMES.SHIP
WHERE dbo.OUTCOMES.RESULT='sunk'
GROUP BY dbo.SHIPS.CLASS

--6. Напишете заявка, която извежда броя на корабите, потънали в битка според класа, за тези класове с повече от 2 кораба.
SELECT COUNT( dbo.SHIPS.NAME), dbo.SHIPS.CLASS
FROM dbo.SHIPS JOIN dbo.OUTCOMES ON dbo.SHIPS.NAME=dbo.OUTCOMES.SHIP
WHERE dbo.OUTCOMES.RESULT='sunk' AND dbo.SHIPS.CLASS IN (SELECT dbo.SHIPS.CLASS FROM dbo.SHIPS GROUP BY dbo.SHIPS.CLASS HAVING COUNT(dbo.SHIPS.NAME)>2)
GROUP BY dbo.SHIPS.CLASS

--7. Напишете заявка, която извежда средния калибър на оръдията на корабите за всяка страна.
SELECT dbo.CLASSES.COUNTRY, AVG(dbo.CLASSES.BORE)
FROM dbo.CLASSES JOIN dbo.SHIPS ON dbo.SHIPS.CLASS=dbo.CLASSES.CLASS
GROUP BY dbo.CLASSES.COUNTRY