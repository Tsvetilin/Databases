--II. За базата от данни SHIPS
USE ships

--1. Напишете заявка, която извежда имената на всички кораби без повторения,
--които са участвали в поне една битка и чиито имена започват с C или K.

SELECT DISTINCT dbo.OUTCOMES.SHIP
FROM dbo.OUTCOMES
WHERE dbo.OUTCOMES.SHIP LIKE 'C%' OR dbo.OUTCOMES.SHIP LIKE 'K%'

--2. Напишете заявка, която извежда име и държава на всички кораби, които
--никога не са потъвали в битка (може и да не са участвали).

SELECT DISTINCT dbo.SHIPS.NAME, dbo.CLASSES.COUNTRY
FROM dbo.SHIPS
	JOIN dbo.CLASSES ON dbo.CLASSES.CLASS = dbo.SHIPS.CLASS
	LEFT JOIN dbo.OUTCOMES ON dbo.OUTCOMES.SHIP = dbo.SHIPS.NAME
WHERE dbo.OUTCOMES.RESULT <> 'sunk' OR dbo.OUTCOMES.RESULT IS NULL

--3. Напишете заявка, която извежда държавата и броя на потъналите кораби за
--тази държава. Държави, които нямат кораби или имат кораб, но той не е
--участвал в битка, също да бъдат изведени.

SELECT DISTINCT dbo.CLASSES.COUNTRY, COUNT(dbo.OUTCOMES.SHIP)
FROM dbo.SHIPS
	RIGHT JOIN dbo.CLASSES ON dbo.CLASSES.CLASS = dbo.SHIPS.CLASS
	LEFT JOIN dbo.OUTCOMES ON dbo.OUTCOMES.SHIP = dbo.SHIPS.NAME
WHERE dbo.OUTCOMES.RESULT = 'sunk' OR dbo.OUTCOMES.RESULT IS NULL
GROUP BY dbo.CLASSES.COUNTRY

--4. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи кораби) от битката при Guadalcanal.

SELECT dbo.OUTCOMES.BATTLE
FROM dbo.OUTCOMES
GROUP BY dbo.OUTCOMES.BATTLE
HAVING COUNT(dbo.OUTCOMES.SHIP) > (SELECT COUNT(dbo.OUTCOMES.SHIP) FROM dbo.OUTCOMES WHERE dbo.OUTCOMES.BATTLE='Guadalcanal')

--5. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи страни) от битката при Surigao Strait.

--6. Напишете заявка, която извежда имената на най-леките кораби с най-много
--оръдия.

--7. Изведете броя на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в друга битка.

--8. Изведете име на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в по-мащабна битка (с повече кораби).
