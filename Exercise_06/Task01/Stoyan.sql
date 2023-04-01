--1. Напишете заявка, която извежда заглавие и година на всички филми, които са
--по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е
--неизвестна, заглавието и годината на този филм също да се изведат.
SELECT TITLE, YEAR, LENGTH
FROM MOVIE
WHERE (LENGTH IS NULL OR LENGTH > 120) AND YEAR < 2000

--2. Напишете заявка, която извежда име и пол на всички актьори (мъже и жени),
--чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде
--подреден по име в намаляващ ред.
SELECT NAME, GENDER
FROM MOVIESTAR
WHERE NAME LIKE 'J%' AND BIRTHDATE > 1948
ORDER BY NAME DESC

--3. Напишете заявка, която извежда име на студио и брой на актьорите,
--участвали във филми, които са създадени от това студио.
SELECT STUDIO.NAME, COUNT(DISTINCT STARSIN.STARNAME) AS ActorsCount
FROM STUDIO JOIN MOVIE ON STUDIO.NAME = MOVIE.STUDIONAME
            JOIN STARSIN ON STARSIN.MOVIETITLE = MOVIE.TITLE
GROUP BY STUDIO.NAME

--4. Напишете заявка, която за всеки актьор извежда име на актьора и броя на
--филмите, в които актьорът е участвал.
SELECT STARSIN.STARNAME, COUNT(MOVIE.TITLE) AS MoviesCount
FROM STUDIO JOIN MOVIE ON STUDIO.NAME = MOVIE.STUDIONAME
            JOIN STARSIN ON STARSIN.MOVIETITLE = MOVIE.TITLE
GROUP BY STARSIN.STARNAME

--5. Напишете заявка, която за всяко студио извежда име на студиото и заглавие
--на филма, излязъл последно на екран за това студио.
SELECT m.STUDIONAME, m.TITLE
FROM MOVIE AS m
WHERE m.TITLE = (SELECT TOP 1 MOVIE.TITLE from MOVIE WHERE MOVIE.STUDIONAME = m.STUDIONAME ORDER BY MOVIE.YEAR DESC)
ORDER BY m.STUDIONAME DESC

--6. Напишете заявка, която извежда името на най-младия актьор (мъж).
SELECT NAME
FROM MOVIESTAR as m
WHERE m.BIRTHDATE >= ALL(SELECT MOVIESTAR.BIRTHDATE FROM MOVIESTAR WHERE MOVIESTAR.GENDER = 'M')
  AND m.GENDER = 'M'

--7. Напишете заявка, която извежда име на актьор и име на студио за тези
--актьори, участвали в най-много филми на това студио.
SELECT  st.NAME, si.STARNAME, COUNT(si.STARNAME)
FROM STARSIN as si JOIN MOVIE ON si.MOVIETITLE = MOVIE.TITLE
                   JOIN STUDIO AS st ON st.NAME = MOVIE.STUDIONAME
GROUP BY si.STARNAME, st.Name
HAVING COUNT(si.STARNAME) = (SELECT TOP 1 COUNT(STARSIN.STARNAME)
FROM STARSIN JOIN MOVIE ON STARSIN.MOVIETITLE = MOVIE.TITLE
    JOIN STUDIO ON STUDIO.NAME = MOVIE.STUDIONAME
WHERE STUDIO.NAME = st.NAME
GROUP BY STARSIN.STARNAME, STUDIO.Name
ORDER BY COUNT(STARSIN.STARNAME) DESC)

--8. Напишете заявка, която извежда заглавие и година на филма, и брой на
--актьорите, участвали в този филм за тези филми с повече от двама актьори.
SELECT m.TITLE, m.YEAR, COUNT(si.STARNAME)
FROM MOVIE AS m JOIN STARSIN as si ON m.TITLE = si.MOVIETITLE
WHERE m.TITLE IN
      (SELECT MOVIE.TITLE
       FROM STARSIN JOIN MOVIE ON STARSIN.MOVIETITLE = MOVIE.TITLE
       GROUP BY MOVIE.TITLE
       HAVING COUNT(STARSIN.STARNAME) > 2)
GROUP BY m.TITLE, m.YEAR