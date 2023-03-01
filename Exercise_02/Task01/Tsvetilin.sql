--I.За базата от данни Movies
USE movies

--1. Напишете заявка, която извежда имената на актьорите мъже, участвали във филма The Usual Suspects.
SELECT dbo.MOVIESTAR.NAME
FROM dbo.MOVIESTAR, dbo.MOVIE, dbo.STARSIN
WHERE dbo.MOVIESTAR.GENDER='M' AND dbo.MOVIE.TITLE='The Usual Suspects' 
		AND dbo.STARSIN.MOVIETITLE = dbo.MOVIE.TITLE 
		AND  dbo.STARSIN.STARNAME=dbo.MOVIESTAR.NAME

--2. Напишете заявка, която извежда имената на актьорите, участвали във филми от 1995, продуцирани от студио MGM.
SELECT dbo.MOVIESTAR.NAME
FROM dbo.MOVIESTAR, dbo.MOVIE, dbo.STARSIN, dbo.STUDIO
WHERE dbo.MOVIE.YEAR=1995 AND dbo.STUDIO.NAME='MGM' 
		AND dbo.STARSIN.MOVIETITLE = dbo.MOVIE.TITLE 
		AND  dbo.STARSIN.STARNAME=dbo.MOVIESTAR.NAME
		AND dbo.MOVIE.STUDIONAME=dbo.STUDIO.NAME

--3. Напишете заявка, която извежда имената на продуцентите, които са продуцирали филми на студио MGM.
SELECT DISTINCT dbo.MOVIEEXEC.NAME
FROM dbo.MOVIEEXEC, dbo.MOVIE, dbo.STUDIO
WHERE dbo.STUDIO.NAME='MGM' 
	AND dbo.MOVIE.STUDIONAME=dbo.STUDIO.NAME 
	AND dbo.MOVIE.PRODUCERC#=dbo.MOVIEEXEC.CERT#

--4. Напишете заявка, която извежда имената на всички филми с дължина, по-голяма от дължината на филма Star Wars.
SELECT dbo.MOVIE.TITLE
FROM dbo.MOVIE
WHERE dbo.MOVIE.LENGTH > (SELECT dbo.MOVIE.LENGTH FROM dbo.MOVIE WHERE dbo.MOVIE.TITLE='Star Wars')

--5. Напишете заявка, която извежда имената на продуцентите с нетни активи поголеми от тези на Stephen Spielberg.
SELECT dbo.MOVIEEXEC.NAME
FROM dbo.MOVIEEXEC
WHERE dbo.MOVIEEXEC.NETWORTH > (SELECT dbo.MOVIEEXEC.NETWORTH FROM dbo.MOVIEEXEC WHERE dbo.MOVIEEXEC.NAME='Stephen Spielberg')