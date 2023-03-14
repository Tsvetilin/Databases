--III. За базата от данни SHIPS
USE ships

--1. Напишете заявка, която извежда цялата налична информация за всеки кораб, включително и данните за неговия клас. 
--В резултата не трябва да се включват тези класове, които нямат кораби.
SELECT * 
FROM dbo.SHIPS RIGHT JOIN dbo.CLASSES ON dbo.CLASSES.CLASS = dbo.SHIPS.CLASS 
WHERE dbo.SHIPS.NAME IS NOT NULL

--or

SELECT * 
FROM dbo.SHIPS LEFT JOIN dbo.CLASSES ON dbo.CLASSES.CLASS = dbo.SHIPS.CLASS 

--2. Повторете горната заявка, като този път включите в резултата и класовете, които нямат кораби, но съществуват кораби със същото име като тяхното.
SELECT * 
FROM dbo.SHIPS FULL JOIN dbo.CLASSES ON dbo.CLASSES.CLASS = dbo.SHIPS.CLASS
WHERE dbo.SHIPS.NAME IS NOT NULL OR (dbo.SHIPS.NAME IS NULL AND dbo.CLASSES.CLASS IN (SELECT dbo.SHIPS.NAME FROM dbo.SHIPS))

--3. За всяка страна изведете имената на корабите, които никога не са участвали в битка.
SELECT DISTINCT dbo.CLASSES.COUNTRY, dbo.SHIPS.NAME
FROM dbo.CLASSES JOIN dbo.SHIPS ON dbo.SHIPS.CLASS = dbo.CLASSES.CLASS 
		FULL JOIN dbo.OUTCOMES ON dbo.SHIPS.NAME = dbo.OUTCOMES.SHIP
WHERE dbo.OUTCOMES.SHIP IS NULL

--4. Намерете имената на всички кораби с поне 7 оръдия, пуснати на вода през 1916, но наречете резултатната колона Ship Name.
SELECT DISTINCT  dbo.SHIPS.NAME AS 'Ship Name'
FROM dbo.CLASSES JOIN dbo.SHIPS ON dbo.SHIPS.CLASS = dbo.CLASSES.CLASS 
WHERE dbo.CLASSES.NUMGUNS>=7 AND dbo.SHIPS.LAUNCHED=1916

--5. Изведете имената на всички потънали в битка кораби, името и дата на провеждане на битките, в които те са потънали. Подредете резултата по име на битката.
SELECT DISTINCT dbo.OUTCOMES.SHIP,dbo.BATTLES.NAME, dbo.BATTLES.DATE
FROM dbo.BATTLES FULL JOIN dbo.OUTCOMES ON dbo.BATTLES.NAME = dbo.OUTCOMES.BATTLE
WHERE dbo.OUTCOMES.RESULT='sunk'
ORDER BY dbo.BATTLES.NAME

--6. Намерете името, водоизместимостта и годината на пускане на вода на всички кораби, които имат същото име като техния клас.
SELECT DISTINCT  dbo.SHIPS.NAME, dbo.CLASSES.DISPLACEMENT, dbo.SHIPS.LAUNCHED
FROM dbo.CLASSES FULL JOIN dbo.SHIPS ON dbo.SHIPS.CLASS = dbo.CLASSES.CLASS 
WHERE dbo.SHIPS.CLASS = dbo.SHIPS.NAME

--7. Намерете всички класове кораби, от които няма пуснат на вода нито един кораб.
SELECT dbo.CLASSES.CLASS
FROM dbo.SHIPS FULL JOIN dbo.CLASSES ON dbo.CLASSES.CLASS = dbo.SHIPS.CLASS
WHERE dbo.SHIPS.NAME IS NULL

--8. Изведете името, водоизместимостта и броя оръдия на корабите, участвали в битката ‘North Atlantic’, а също и резултата от битката.
SELECT DISTINCT dbo.SHIPS.NAME, dbo.CLASSES.DISPLACEMENT, dbo.CLASSES.NUMGUNS, dbo.OUTCOMES.RESULT
FROM dbo.CLASSES JOIN dbo.SHIPS ON dbo.SHIPS.CLASS = dbo.CLASSES.CLASS 
		FULL JOIN dbo.OUTCOMES ON dbo.SHIPS.NAME = dbo.OUTCOMES.SHIP
WHERE dbo.OUTCOMES.BATTLE='North Atlantic'
