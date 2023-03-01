--1. Напишете заявка, която извежда имената на актьорите мъже,
--участвали във филма The Usual Suspects.
SELECT NAME
FROM MOVIESTAR, STARSIN
WHERE GENDER='M' AND
MOVIETITLE = 'The Usual Suspects' AND
STARNAME = NAME

--2. Напишете заявка, която извежда имената на актьорите, участвали
-- във филми от 1995, продуцирани от студио MGM.
SELECT STARNAME 
FROM MOVIE, STARSIN, STUDIO
WHERE YEAR = 1995 AND 
STUDIO.NAME = 'MGM' AND
STUDIONAME = STUDIO.NAME AND
MOVIETITLE = TITLE

--3. Напишете заявка, която извежда имената на продуцентите, които са
--продуцирали филми на студио MGM.
SELECT DISTINCT MOVIEEXEC.NAME 
FROM STUDIO, MOVIEEXEC, MOVIE
WHERE STUDIO.NAME = 'MGM' AND 
CERT# = PRODUCERC# AND 
STUDIONAME = STUDIO.NAME

--4. Напишете заявка, която извежда имената на всички филми с дължина,
--поголяма от дължината на филма Star Wars.
SELECT TITLE 
FROM MOVIE 
WHERE LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Star Wars')

--5. Напишете заявка, която извежда имената на продуцентите с нетни 
--активи поголеми от тези на Stephen Spielberg.
SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE name = 'Stephen Spielberg')
