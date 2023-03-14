--1. напишете заявка, която извежда имената на актрисите, които са също и
--продуценти с нетни активи над 10 милиона.
SELECT MOVIESTAR.NAME
FROM MOVIESTAR
WHERE MOVIESTAR.GENDER = 'F' AND 
MOVIESTAR.NAME IN (SELECT MOVIEEXEC.NAME FROM MOVIEEXEC WHERE MOVIEEXEC.NETWORTH > 10000000)

--2. напишете заявка, която извежда имената на тези актьори (мъже и жени),
--които не са продуценти.
SELECT MOVIESTAR.NAME
FROM MOVIESTAR
WHERE MOVIESTAR.NAME NOT IN (SELECT MOVIEEXEC.NAME FROM MOVIEEXEC)

--3. напишете заявка, която извежда имената на всички филми с дължина,
--по-голяма от дължината на филма ‘star wars’
SELECT TITLE
FROM MOVIE
WHERE LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'star wars') 

--4. напишете заявка, която извежда имената на продуцентите и имената на
--филмите за всички филми, които са продуцирани от продуценти с нетни
--активи по-големи от тези на ‘merv griffin’
SELECT MOVIE.TITLE, MOVIEEXEC.NAME
FROM MOVIEEXEC, MOVIE
WHERE NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'merv griffin') AND
MOVIE.PRODUCERC# = MOVIEEXEC.CERT#
