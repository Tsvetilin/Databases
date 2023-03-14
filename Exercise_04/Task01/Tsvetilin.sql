--I. За базата от данни Movies
USE movies

--1. Напишете заявка, която извежда името на продуцента и имената на филмите, продуцирани от продуцента на филма ‘Star Wars’.
SELECT dbo.MOVIE.TITLE, dbo.MOVIEEXEC.NAME
FROM dbo.MOVIE JOIN dbo.MOVIEEXEC ON dbo.MOVIE.PRODUCERC# = dbo.MOVIEEXEC.CERT#
WHERE dbo.MOVIEEXEC.CERT# = (SELECT TOP 1 dbo.MOVIE.PRODUCERC# FROM dbo.MOVIE WHERE dbo.MOVIE.TITLE = 'Star Wars')

--2. Напишете заявка, която извежда имената на продуцентите на филмите, в които е участвал ‘Harrison Ford’.
SELECT DISTINCT dbo.MOVIEEXEC.NAME
FROM dbo.MOVIEEXEC JOIN dbo.MOVIE ON dbo.MOVIEEXEC.CERT#=dbo.MOVIE.PRODUCERC#
	JOIN dbo.STARSIN ON dbo.STARSIN.MOVIETITLE = dbo.MOVIE.TITLE
WHERE dbo.STARSIN.STARNAME = 'Harrison Ford'

--3. Напишете заявка, която извежда името на студиото и имената на
--актьорите, участвали във филми, произведени от това студио, подредени по име на студио.
SELECT DISTINCT dbo.STUDIO.NAME, dbo.STARSIN.STARNAME
FROM dbo.STUDIO JOIN dbo.MOVIE ON dbo.STUDIO.NAME=dbo.MOVIE.STUDIONAME
	JOIN dbo.STARSIN ON dbo.STARSIN.MOVIETITLE = dbo.MOVIE.TITLE
ORDER BY dbo.STUDIO.NAME

--4. Напишете заявка, която извежда имената на актьорите, участвали във филми на продуценти с най-големи нетни активи.
SELECT DISTINCT dbo.STARSIN.STARNAME, dbo.MOVIEEXEC.NETWORTH, dbo.MOVIE.TITLE
FROM dbo.MOVIEEXEC JOIN dbo.MOVIE ON dbo.MOVIEEXEC.CERT#=dbo.MOVIE.PRODUCERC#
	JOIN dbo.STARSIN ON dbo.STARSIN.MOVIETITLE = dbo.MOVIE.TITLE
WHERE dbo.MOVIEEXEC.NETWORTH = (SELECT TOP 1 dbo.MOVIEEXEC.NETWORTH FROM dbo.MOVIEEXEC ORDER BY dbo.MOVIEEXEC.NETWORTH DESC)

--5. Напишете заявка, която извежда имената на актьорите, които не са участвали в нито един филм.
SELECT dbo.MOVIESTAR.NAME
FROM dbo.MOVIESTAR LEFT JOIN dbo.STARSIN ON dbo.STARSIN.STARNAME = dbo.MOVIESTAR.NAME
WHERE dbo.STARSIN.MOVIETITLE IS NULL
