--1. Напишете заявка, която извежда страните, чиито кораби са с най-голям
--брой оръдия.
SELECT DISTINCT COUNTRY
FROM CLASSES 
WHERE NUMGUNS >= ALL(SELECT NUMGUNS FROM CLASSES)

--2. Напишете заявка, която извежда класовете, за които поне един от
--корабите е потънал в битка.
SELECT CLASS 
FROM CLASSES
WHERE CLASS IN (SELECT CLASS FROM SHIPS WHERE NAME IN
(SELECT SHIP FROM OUTCOMES WHERE RESULT = 'sunk'))

--3. Напишете заявка, която извежда името и класа на корабите с 16 инчови
--оръдия.
SELECT NAME, CLASS
FROM SHIPS
WHERE CLASS IN (SELECT CLASS FROM CLASSES WHERE BORE = 16)

--4. Напишете заявка, която извежда имената на битките, в които са
--участвали кораби от клас ‘Kongo’.
SELECT BATTLE 
FROM OUTCOMES
WHERE SHIP IN (SELECT NAME FROM SHIPS WHERE CLASS = 'Kongo')

--5. Напишете заявка, която извежда класа и името на корабите, чиито брой
--оръдия е по-голям или равен на този на корабите със същия калибър
--оръдия.
SELECT CLASS, NAME
FROM SHIPS
WHERE CLASS IN (SELECT c.CLASS FROM CLASSES AS c WHERE c.NUMGUNS >= 
ALL(SELECT p.NUMGUNS FROM CLASSES AS p WHERE p.BORE = c.BORE))
ORDER BY CLASS
