--1. Напишете заявка, която извежда името на продуцента и имената на
--филмите, продуцирани от продуцента на филма ‘Star Wars’.

SELECT Name, Title
FROM MOVIEEXEC LEFT JOIN MOVIE
                         ON MOVIEEXEC.CERT# = MOVIE.PRODUCERC#
WHERE MOVIEEXEC.CERT# = (SELECT PRODUCERC#
                         FROM MOVIE
                         WHERE MOVIE.TITLE = 'Star Wars')

--2. Напишете заявка, която извежда имената на продуцентите на филмите, в
--които е участвал ‘Harrison Ford’.

SELECT DISTINCT m.NAME
FROM STARSIN n JOIN
     (SELECT MOVIEEXEC.NAME, MOVIE.YEAR
      FROM MOVIEEXEC JOIN MOVIE
                          ON MOVIEEXEC.CERT# = MOVIE.PRODUCERC#) m
     ON m.YEAR = n.MOVIEYEAR
WHERE n.STARNAME = 'Harrison Ford'

--3. Напишете заявка, която извежда името на студиото и имената на
--актьорите, участвали във филми, произведени от това студио, подредени
--по име на студио.
SELECT DISTINCT SM.NAME, STARNAME
FROM STARSIN JOIN (SELECT NAME, TITLE, STUDIONAME
                   FROM STUDIO, MOVIE
                   WHERE NAME = STUDIONAME) SM
                  ON SM.TITLE = STARSIN.MOVIETITLE

--4. Напишете заявка, която извежда имената на актьорите, участвали във
--филми на продуценти с най-големи нетни активи.
SELECT ST.STARNAME, MS.NETWORTH, MS.TITLE
FROM STARSIN AS ST JOIN
     (SELECT TITLE, NETWORTH
      FROM MOVIE, MOVIEEXEC
      WHERE MOVIE.PRODUCERC# = MOVIEEXEC.CERT# AND
              NAME IN (SELECT TOP 1 NAME
                       FROM MOVIEEXEC
                       WHERE NETWORTH >= ALL
                             (SELECT NETWORTH FROM MOVIEEXEC))) MS
     ON MS.TITLE = ST.MOVIETITLE

--5. Напишете заявка, която извежда имената на актьорите, които не са
--участвали в нито един филм.
SELECT MOVIESTAR.NAME
FROM MOVIESTAR
WHERE MOVIESTAR.NAME NOT IN (
    SELECT STARNAME
    FROM MOVIE JOIN STARSIN
                    ON MOVIE.TITLE = STARSIN.MOVIETITLE)

