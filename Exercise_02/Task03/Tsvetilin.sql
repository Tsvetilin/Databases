--III.За базата от данни SHIPS
USE ships

--1. Напишете заявка, която извежда името на корабите с водоизместимост над 50000.
SELECT dbo.SHIPS.NAME
FROM dbo.SHIPS, dbo.CLASSES
WHERE dbo.SHIPS.CLASS=dbo.CLASSES.CLASS AND dbo.CLASSES.DISPLACEMENT>50000

--2. Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на всички кораби, участвали в битката при Guadalcanal.
SELECT dbo.SHIPS.NAME, dbo.CLASSES.DISPLACEMENT, dbo.CLASSES.NUMGUNS
FROM dbo.SHIPS, dbo.CLASSES, dbo.OUTCOMES, dbo.BATTLES
WHERE dbo.BATTLES.NAME='Guadalcanal' 
	AND dbo.SHIPS.CLASS=dbo.CLASSES.CLASS 
	AND dbo.OUTCOMES.SHIP=dbo.SHIPS.NAME 
	AND dbo.OUTCOMES.BATTLE = dbo.BATTLES.NAME

--3. Напишете заявка, която извежда имената на тези държави, които имат както бойни кораби, така и бойни крайцери.
SELECT DISTINCT dbo.CLASSES.COUNTRY
FROM dbo.SHIPS, dbo.CLASSES, dbo.OUTCOMES
WHERE dbo.CLASSES.TYPE='bb' AND dbo.CLASSES.CLASS=dbo.SHIPS.CLASS
INTERSECT
SELECT DISTINCT dbo.CLASSES.COUNTRY
FROM dbo.SHIPS, dbo.CLASSES, dbo.OUTCOMES
WHERE dbo.CLASSES.TYPE='bc' AND dbo.CLASSES.CLASS=dbo.SHIPS.CLASS

--4. Напишете заявка, която извежда имената на тези кораби, които са били повредени в една битка, но по-късно са участвали в друга битка.
SELECT dbo.SHIPS.NAME
FROM dbo.SHIPS, dbo.OUTCOMES AS O1, dbo.BATTLES AS B1, dbo.OUTCOMES AS O2, dbo.BATTLES AS B2
WHERE   O1.SHIP=dbo.SHIPS.NAME 
	AND B1.NAME = O1.BATTLE
	AND O2.SHIP=dbo.SHIPS.NAME 
	AND B2.NAME = O2.BATTLE
	AND O1.RESULT='damaged'
	AND B2.DATE>B1.DATE
