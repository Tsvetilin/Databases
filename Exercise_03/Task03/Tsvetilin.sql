--III.За базата от данни SHIPS
USE ships

--1. Напишете заявка, която извежда страните, чиито кораби са с най-голям брой оръдия.
SELECT DISTINCT dbo.CLASSES.COUNTRY
FROM dbo.CLASSES
WHERE dbo.CLASSES.NUMGUNS = (SELECT TOP 1 dbo.CLASSES.NUMGUNS FROM dbo.CLASSES ORDER BY dbo.CLASSES.NUMGUNS DESC)

--2. Напишете заявка, която извежда класовете, за които поне един от корабите е потънал в битка.
SELECT DISTINCT dbo.SHIPS.CLASS
FROM dbo.SHIPS
WHERE dbo.SHIPS.NAME IN (SELECT dbo.OUTCOMES.SHIP FROM dbo.OUTCOMES WHERE dbo.OUTCOMES.RESULT='sunk')

--3. Напишете заявка, която извежда името и класа на корабите с 16 инчови оръдия.
SELECT DISTINCT dbo.SHIPS.NAME, dbo.SHIPS.CLASS
FROM dbo.SHIPS
WHERE dbo.SHIPS.CLASS IN (SELECT dbo.CLASSES.CLASS FROM dbo.CLASSES WHERE dbo.CLASSES.BORE=16)

--4. Напишете заявка, която извежда имената на битките, в които са участвали кораби от клас ‘Kongo’.
SELECT DISTINCT dbo.BATTLES.NAME
FROM dbo.BATTLES
WHERE dbo.BATTLES.NAME IN(SELECT dbo.OUTCOMES.BATTLE FROM dbo.OUTCOMES WHERE dbo.OUTCOMES.SHIP IN (SELECT dbo.SHIPS.NAME FROM dbo.SHIPS WHERE dbo.SHIPS.CLASS='Kongo'))

--5. Напишете заявка, която извежда класа и името на корабите, чиито брой оръдия е по-голям или равен на този на корабите със същия калибър оръдия.
SELECT dbo.SHIPS.CLASS, dbo.SHIPS.NAME
FROM dbo.SHIPS
WHERE dbo.SHIPS.CLASS IN (SELECT C.CLASS FROM dbo.CLASSES AS C WHERE C.NUMGUNS >= ALL (SELECT dbo.CLASSES.NUMGUNS FROM dbo.CLASSES WHERE dbo.CLASSES.BORE = C.BORE))
