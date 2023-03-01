--II.За базата от данни PC
USE pc

--1. Напишете заявка, която извежда модел, честота и размер на диска за всички персонални компютри с цена под 1200 долара. Задайте псевдоними за атрибутите честота и размер на диска, съответно MHz и GB
SELECT dbo.pc.model, dbo.pc.speed AS GHz,dbo.pc.hd AS GB
FROM dbo.pc
WHERE dbo.pc.price<1200

--2. Напишете заявка, която извежда производителите на принтери без повторения
SELECT DISTINCT dbo.product.maker
FROM dbo.product, dbo.printer
WHERE dbo.printer.model=dbo.product.model

--3. Напишете заявка, която извежда модел, размер на паметта, размер на екран за лаптопите, чиято цена е над 1000 долара
SELECT dbo.laptop.model, dbo.laptop.hd, dbo.laptop.screen
FROM dbo.laptop
WHERE dbo.laptop.price>1000

--4. Напишете заявка, която извежда всички цветни принтери
SELECT dbo.printer.code
FROM dbo.printer
WHERE dbo.printer.color='Y'

--5. Напишете заявка, която извежда модел, честота и размер на диска за тези персонални компютри със CD 12x или 16x и цена под 2000 долара.
SELECT dbo.pc.model, dbo.pc.speed, dbo.pc.hd
FROM dbo.pc
WHERE (dbo.pc.cd='12x' OR dbo.pc.cd='16x') AND dbo.pc.price<2000
