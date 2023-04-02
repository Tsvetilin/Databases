--1. Напишете заявка, която извежда средната честота на персоналните компютри.
SELECT AVG(PC.SPEED) AS AvgSpeed
FROM PC

--2. Напишете заявка, която извежда средния размер на екраните на лаптопите за
--всеки производител.
SELECT MAKER, AVG(SCREEN) AS AvgScreen
FROM LAPTOP JOIN PRODUCT
                 ON LAPTOP.MODEL = PRODUCT.MODEL
GROUP BY MAKER

--3. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.
SELECT AVG(SPEED)
FROM LAPTOP
WHERE PRICE > 1000

--4. Напишете заявка, която извежда средната цена на персоналните компютри,
--произведени от производител ‘A’.
SELECT AVG(PC.PRICE)
FROM PC JOIN PRODUCT ON
        PC.MODEL = PRODUCT.MODEL
WHERE PRODUCT.MAKER = 'A'

--5. Напишете заявка, която извежда средната цена на персоналните компютри и
--лаптопите за производител ‘B’.
SELECT AVG(PRICE)
FROM (SELECT L.MODEL, L.PRICE
      FROM LAPTOP AS L
      UNION ALL
      SELECT P.MODEL, P.PRICE
      FROM PC AS P) AS T JOIN PRODUCT
                              ON PRODUCT.MODEL = T.MODEL
WHERE PRODUCT.MAKER = 'B'

--6. Напишете заявка, която извежда средната цена на персоналните компютри
--според различните им честоти.
SELECT PC.SPEED, AVG(PC.PRICE)
FROM PC
GROUP BY PC.SPEED

--7. Напишете заявка, която извежда производителите, които са произвели поне 3
--различни персонални компютъра (с различен код).
SELECT PRODUCT.MAKER, COUNT(PC.CODE)
FROM PRODUCT JOIN PC
                  ON PRODUCT.MODEL = PC.MODEL
GROUP BY PRODUCT.MAKER
HAVING COUNT(PC.CODE) >= 3

--8. Напишете заявка, която извежда производителите с най-висока цена на
--персонален компютър.
SELECT PRODUCT.MAKER, PC.PRICE
FROM PRODUCT JOIN PC
                  ON PRODUCT.MODEL = PC.MODEL
WHERE PC.PRICE = (SELECT MAX(PC.PRICE) FROM PC)

--or

SELECT PRODUCT.MAKER, PC.PRICE
FROM PRODUCT JOIN PC
                  ON PRODUCT.MODEL = PC.MODEL
GROUP BY PC.PRICE, PRODUCT.MAKER
HAVING PC.PRICE >= ALL(SELECT PC.PRICE FROM PC)

--9. Напишете заявка, която извежда средната цена на персоналните компютри за
--всяка честота по-голяма от 800.
SELECT AVG(PC.SPEED), AVG(PC.PRICE)
FROM PC
WHERE PC.SPEED > 800

--10.Напишете заявка, която извежда средния размер на диска на тези персонални
--компютри, произведени от производители, които произвеждат и принтери.
--Резултатът да се изведе за всеки отделен производител.
SELECT PRODUCT.MAKER, AVG(PC.HD)
FROM PC JOIN PRODUCT ON PC.MODEL = PRODUCT.MODEL
WHERE MAKER IN (SELECT DISTINCT MAKER
                FROM PRODUCT JOIN PC
                                  ON PRODUCT.MODEL = PC.MODEL

                INTERSECT

                SELECT DISTINCT MAKER
                FROM PRODUCT JOIN PRINTER
                                  ON PRODUCT.MODEL = PRINTER.MODEL)
GROUP BY PRODUCT.MAKER
