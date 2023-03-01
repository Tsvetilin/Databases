--1. Напишете заявка, която извежда името на корабите с водоизместимост
--над 50000
SELECT NAME 
FROM SHIPS, CLASSES 
WHERE DISPLACEMENT > 50000 AND CLASSES.CLASS = SHIPS.CLASS

--2. Напишете заявка, която извежда имената, водоизместимостта и
--броя оръдия на всички кораби, участвали в битката при Guadalcanal
SELECT SHIPS.NAME, DISPLACEMENT, NUMGUNS 
FROM CLASSES, SHIPS, BATTLES, OUTCOMES
WHERE BATTLES.NAME = 'Guadalcanal' AND
BATTLES.NAME = OUTCOMES.BATTLE AND
OUTCOMES.SHIP = SHIPS.NAME AND
SHIPS.CLASS = CLASSES.CLASS

--3. Напишете заявка, която извежда имената на тези държави, 
--които имат както бойни кораби, така и бойни крайцери.
SELECT COUNTRY
FROM CLASSES
WHERE TYPE='bb'

INTERSECT

SELECT country
FROM CLASSES
WHERE TYPE='bc'

--4. Напишете заявка, която извежда имената на тези кораби, 
--които са били повредени в една битка, но по-късно са 
--участвали в друга битка
SELECT SHIPS.NAME 
FROM SHIPS, OUTCOMES as O1, OUTCOMES as O2, BATTLES as B1, BATTLES as B2
WHERE SHIPS.NAME=O1.ship AND
O2.ship = SHIPS.NAME AND
B1.NAME = O1.BATTLE AND
B2.NAME = O2.BATTLE AND
O1.RESULT = 'damaged' AND
B1.DATE < B2.DATE

