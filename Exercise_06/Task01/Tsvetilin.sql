--I. За базата от данни MOVIES
USE movies

--1. Напишете заявка, която извежда заглавие и година на всички филми, които са
--по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е
--неизвестна, заглавието и годината на този филм също да се изведат.

SELECT dbo.MOVIE.TITLE,dbo.MOVIE.YEAR
FROM dbo.MOVIE
WHERE dbo.MOVIE.YEAR < 2000 AND (dbo.MOVIE.LENGTH>120 OR dbo.MOVIE.LENGTH IS NULL)

--2. Напишете заявка, която извежда име и пол на всички актьори (мъже и жени),
--чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде
--подреден по име в намаляващ ред.

SELECT dbo.MOVIESTAR.NAME, dbo.MOVIESTAR.GENDER
FROM dbo.MOVIESTAR
WHERE dbo.MOVIESTAR.NAME LIKE 'J%' AND dbo.MOVIESTAR.BIRTHDATE>1948
ORDER BY dbo.MOVIESTAR.NAME DESC

--3. Напишете заявка, която извежда име на студио и брой на актьорите,
--участвали във филми, които са създадени от това студио.

SELECT dbo.STUDIO.NAME, COUNT(DISTINCT dbo.STARSIN.STARNAME)
FROM dbo.STUDIO
LEFT OUTER JOIN dbo.MOVIE ON dbo.MOVIE.STUDIONAME=dbo.STUDIO.NAME
LEFT OUTER JOIN dbo.STARSIN ON dbo.STARSIN.MOVIETITLE = dbo.MOVIE.TITLE
GROUP BY dbo.STUDIO.NAME

--4. Напишете заявка, която за всеки актьор извежда име на актьора и броя на
--филмите, в които актьорът е участвал.

SELECT dbo.STARSIN.STARNAME, COUNT(DISTINCT dbo.STARSIN.MOVIETITLE)
FROM dbo.STARSIN
GROUP BY dbo.STARSIN.STARNAME

--5. Напишете заявка, която за всяко студио извежда име на студиото и заглавие
--на филма, излязъл последно на екран за това студио.

SELECT m.STUDIONAME, m.TITLE
FROM dbo.MOVIE as m
WHERE m.TITLE = (SELECT TOP 1 dbo.MOVIE.TITLE FROM dbo.MOVIE WHERE dbo.MOVIE.STUDIONAME=m.STUDIONAME ORDER BY dbo.MOVIE.YEAR DESC)

--6. Напишете заявка, която извежда името на най-младия актьор (мъж).

SELECT TOP 1 dbo.MOVIESTAR.NAME
FROM dbo.MOVIESTAR
WHERE dbo.MOVIESTAR.GENDER = 'M'
ORDER  BY dbo.MOVIESTAR.BIRTHDATE DESC

--7. Напишете заявка, която извежда име на актьор и име на студио за тези
--актьори, участвали в най-много филми на това студио.

SELECT tm.STUDIONAME, ts.STARNAME
FROM  dbo.MOVIE as tm
JOIN dbo.STARSIN as ts ON tm.TITLE = ts.MOVIETITLE
WHERE ts.STARNAME =
(SELECT TOP 1 s.STARNAME
FROM dbo.MOVIE as m
	JOIN dbo.STARSIN as s ON s.MOVIETITLE=m.TITLE
WHERE m.STUDIONAME=tm.STUDIONAME
GROUP BY m.STUDIONAME, s.STARNAME
ORDER BY COUNT(s.STARNAME))

--8. Напишете заявка, която извежда заглавие и година на филма, и брой на
--актьорите, участвали в този филм за тези филми с повече от двама актьори.

SELECT  m.TITLE, m.YEAR, COUNT(s.STARNAME) AS count
FROM dbo.MOVIE as m
	JOIN dbo.STARSIN as s ON s.MOVIETITLE=m.TITLE
GROUP BY m.TITLE,m.YEAR
HAVING COUNT(s.STARNAME)>2
