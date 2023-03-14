--1. Напишете заявка, която извежда производителите на персонални
--компютри с честота над 500.
SELECT MAKER
FROM PRODUCT
WHERE PRODUCT.MODEL IN (SELECT PC.MODEL FROM PC WHERE speed > 500)

--2. Напишете заявка, която извежда код, модел и цена на принтерите с най-висока цена.
SELECT CODE, MODEL, PRICE
FROM PRINTER
WHERE PRICE >= ALL(SELECT PRICE FROM PRINTER)

--3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
--честотата на всички персонални компютри.
SELECT *
FROM LAPTOP
WHERE SPEED < ALL(SELECT SPEED FROM PC)

--4. Напишете заявка, която извежда модела и цената на продукта (PC,
--лаптоп или принтер) с най-висока цена.
SELECT TOP 1 MODEL, PRICE
FROM ((SELECT MODEL, PRICE FROM PC) UNION (SELECT MODEL, PRICE FROM LAPTOP) UNION (SELECT MODEL, PRICE FROM PRINTER)) AS t
ORDER BY PRICE DESC

--5. Напишете заявка, която извежда производителя на цветния принтер с
--най-ниска цена.
SELECT TOP 1 MAKER
FROM PRODUCT, PRINTER
WHERE PRINTER.MODEL = PRODUCT.MODEL AND
PRINTER.PRICE <= ALL(SELECT PRICE FROM PRINTER WHERE PRINTER.COLOR = 'y')

--6. Напишете заявка, която извежда производителите на тези персонални
--компютри с най-малко RAM памет, които имат най-бързи процесори.
SELECT DISTINCT MAKER
FROM PRODUCT 
WHERE PRODUCT.MODEL IN
(SELECT P.MODEL FROM PC AS P WHERE 
P.SPEED = (SELECT TOP 1 C.SPEED FROM PC AS C WHERE
C.RAM <= ALL(SELECT P.RAM FROM PC AS P) ORDER BY P.speed DESC))
