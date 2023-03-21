--I. За базата от данни PC
USE pc

--1. Напишете заявка, която извежда средната честота на персоналните компютри.
SELECT ROUND(AVG(speed),2) AS Average
FROM dbo.pc

--2. Напишете заявка, която извежда средния размер на екраните на лаптопите за всеки производител.
SELECT AVG(laptop.screen) AS AvgScreen, dbo.product.maker
FROM dbo.laptop JOIN dbo.product ON dbo.product.model=dbo.laptop.model
GROUP BY dbo.product.maker

--3. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.
SELECT AVG(laptop.speed) AS AvgSpeed
FROM dbo.laptop 
WHERE laptop.price > 1000

--4. Напишете заявка, която извежда средната цена на персоналните компютри, произведени от производител ‘A’.
SELECT AVG(dbo.pc.price) AS AvgPrice
FROM dbo.pc JOIN dbo.product ON dbo.product.model=dbo.pc.model
WHERE dbo.product.maker = 'A'

--5. Напишете заявка, която извежда средната цена на персоналните компютри и лаптопите за производител ‘B’.
SELECT (SUM(dbo.laptop.price) + SUM(dbo.pc.price)) / COUNT(*) AS AvgPrice
FROM dbo.product 
	FULL OUTER JOIN dbo.pc ON dbo.product.model=dbo.pc.model
	FULL OUTER JOIN dbo.laptop ON dbo.product.model=dbo.laptop.model
WHERE dbo.product.maker = 'B'

-- or 

SELECT AVG(price)
FROM 
((SELECT price FROM dbo.product JOIN dbo.pc ON dbo.product.model=dbo.pc.model WHERE dbo.product.maker = 'B')
UNION ALL
(SELECT price FROM dbo.product JOIN dbo.laptop ON dbo.product.model=dbo.laptop.model WHERE dbo.product.maker = 'B'))t


--6. Напишете заявка, която извежда средната цена на персоналните компютри според различните им честоти.
SELECT AVG(dbo.pc.price) AS AvgPrice, dbo.pc.speed
FROM dbo.pc
GROUP BY dbo.pc.speed

--7. Напишете заявка, която извежда производителите, които са произвели поне 3 различни персонални компютъра (с различен код).
SELECT dbo.product.maker, COUNT(DISTINCT dbo.pc.code) AS Count
FROM dbo.pc JOIN dbo.product ON dbo.product.model=dbo.pc.model
GROUP BY dbo.product.maker
HAVING COUNT(DISTINCT dbo.pc.code)>2

--8. Напишете заявка, която извежда производителите с най-висока цена на персонален компютър.
SELECT DISTINCT dbo.product.maker, dbo.pc.price
FROM dbo.product JOIN dbo.pc ON pc.model=product.model
WHERE dbo.pc.price = (SELECT MAX(price) FROM dbo.pc)

--9. Напишете заявка, която извежда средната цена на персоналните компютри за всяка честота по-голяма от 800.
SELECT AVG(dbo.pc.price) AS speed, dbo.pc.speed
FROM dbo.pc
GROUP BY dbo.pc.speed
HAVING dbo.pc.speed > 800

--10.Напишете заявка, която извежда средния размер на диска на тези персонални компютри, произведени от производители, които произвеждат и принтери.
--Резултатът да се изведе за всеки отделен производител.

SELECT AVG(dbo.pc.hd) AS HD, dbo.product.maker
FROM dbo.product JOIN dbo.pc ON dbo.product.model = dbo.pc.model
WHERE dbo.product.maker IN (SELECT DISTINCT dbo.product.maker FROM dbo.printer JOIN dbo.product ON dbo.printer.model = dbo.product.model)
GROUP BY dbo.product.maker
