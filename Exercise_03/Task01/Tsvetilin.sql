--I.За базата от данни Movies
USE movies

--1. Напишете заявка, която извежда имената на актрисите, които са също и продуценти с нетни активи над 10 милиона.
SELECT dbo.MOVIESTAR.NAME
FROM dbo.MOVIESTAR
WHERE dbo.MOVIESTAR.NAME IN (SELECT dbo.MOVIEEXEC.NAME FROM dbo.MOVIEEXEC WHERE dbo.MOVIEEXEC.NETWORTH > 10000000)

--2. Напишете заявка, която извежда имената на тези актьори (мъже и жени), които не са продуценти.
SELECT dbo.MOVIESTAR.NAME
FROM dbo.MOVIESTAR
WHERE dbo.MOVIESTAR.NAME NOT IN (SELECT dbo.MOVIEEXEC.NAME FROM dbo.MOVIEEXEC)

--3. Напишете заявка, която извежда имената на всички филми с дължина, по-голяма от дължината на филма ‘Star Wars’
SELECT dbo.MOVIE.TITLE
FROM dbo.MOVIE
WHERE dbo.MOVIE.LENGTH > (SELECT dbo.MOVIE.LENGTH FROM dbo.MOVIE WHERE dbo.MOVIE.TITLE = 'Star Wars')

--4. Напишете заявка, която извежда имената на продуцентите и имената на филмите за всички филми, които са продуцирани от продуценти с нетни активи по-големи от тези на ‘Merv Griffin’
SELECT M.TITLE, EX.NAME
FROM dbo.MOVIE AS M, dbo.MOVIEEXEC AS EX
WHERE M.PRODUCERC# = EX.CERT#
	 AND EX.NETWORTH > (SELECT dbo.MOVIEEXEC.NETWORTH FROM dbo.MOVIEEXEC WHERE dbo.MOVIEEXEC.NAME = 'Merv Griffin')
