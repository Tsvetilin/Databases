--III.За базата от данни SHIPS
USE ships

--1. Напишете заявка, която извежда класа и страната за всички класове с помалко от 10 оръдия.
SELECT dbo.CLASSES.CLASS, dbo.CLASSES.COUNTRY
FROM dbo.CLASSES
WHERE dbo.CLASSES.NUMGUNS<10

--2. Напишете заявка, която извежда имената на корабите, пуснати на вода преди 1918. Задайте псевдоним shipName на колоната.
SELECT dbo.SHIPS.NAME AS shipName
FROM dbo.SHIPS
WHERE dbo.SHIPS.LAUNCHED<1918

--3. Напишете заявка, която извежда имената на корабите потънали в битка и имената на съответните битки.
SELECT dbo.OUTCOMES.SHIP, dbo.OUTCOMES.BATTLE
FROM dbo.OUTCOMES
WHERE dbo.OUTCOMES.RESULT='sinked'

--4. Напишете заявка, която извежда имената на корабите с име, съвпадащо с името на техния клас.
SELECT dbo.SHIPS.CLASS
FROM dbo.SHIPS
WHERE dbo.SHIPS.CLASS=dbo.SHIPS.NAME

--5. Напишете заявка, която извежда имената на корабите, които започват с буквата R.
SELECT dbo.SHIPS.NAME
FROM dbo.SHIPS
WHERE dbo.SHIPS.NAME LIKE 'R%'

--6. Напишете заявка, която извежда имената на корабите, които съдържат 2 или повече думи.
SELECT dbo.SHIPS.NAME
FROM dbo.SHIPS
WHERE dbo.SHIPS.NAME LIKE '% %'
