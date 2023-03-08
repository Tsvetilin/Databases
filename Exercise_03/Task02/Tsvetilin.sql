
--II.За базата от данни PC
USE pc

--1. Напишете заявка, която извежда производителите на персонални компютри с честота над 500.
SELECT DISTINCT P.maker
FROM dbo.product AS P, dbo.pc AS PC
WHERE P.model = PC.model
	AND PC.speed > 500

-- or

SELECT dbo.product.maker
FROM dbo.product
WHERE dbo.product.model IN (SELECT dbo.pc.model FROM dbo.pc WHERE dbo.pc.speed>500)

--2. Напишете заявка, която извежда код, модел и цена на принтерите с най-висока цена.
SELECT dbo.printer.code, dbo.printer.model, dbo.printer.price
FROM dbo.printer
WHERE dbo.printer.price = (SELECT TOP 1 dbo.printer.price FROM dbo.printer ORDER BY dbo.printer.price DESC)

--3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от честотата на всички персонални компютри.
SELECT dbo.laptop.code
FROM dbo.laptop
WHERE dbo.laptop.speed < ALL(SELECT dbo.pc.speed FROM dbo.pc)

--4. Напишете заявка, която извежда модела и цената на продукта (PC, лаптоп или принтер) с най-висока цена.
SELECT TOP 1 model, price
FROM ((SELECT model ,price  FROM dbo.pc) UNION (SELECT model ,price  FROM dbo.laptop) UNION (SELECT model ,price  FROM dbo.printer) ) t
ORDER BY price DESC

--5. Напишете заявка, която извежда производителя на цветния принтер с най-ниска цена.
SELECT dbo.product.maker
FROM dbo.product
WHERE dbo.product.model = (SELECT TOP 1 dbo.printer.model FROM dbo.printer WHERE dbo.printer.color='y' ORDER BY dbo.printer.price ASC)

--6. Напишете заявка, която извежда производителите на тези персонални компютри с най-малко RAM памет, които имат най-бързи процесори.
SELECT dbo.product.maker
FROM dbo.product
WHERE dbo.product.model IN  (SELECT P.model FROM dbo.pc AS P WHERE P.speed = (SELECT TOP 1 dbo.pc.speed FROM dbo.pc WHERE dbo.pc.ram=(SELECT TOP 1 dbo.pc.ram FROM dbo.pc ORDER BY dbo.pc.ram ASC) AND P.code=dbo.pc.code ORDER BY  dbo.pc.ram ASC)) 
