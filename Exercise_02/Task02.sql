--1. Напишете заявка, която извежда производителя и честотата 
--на лаптопите с размер на диска поне 9 GB.
SELECT MAKER, SPEED
FROM PRODUCT, LAPTOP
WHERE HD >= 9 AND PRODUCT.MODEL = LAPTOP.MODEL

--2. Напишете заявка, която извежда модел и цена на продуктите,
--произведени от производител с име B.

SELECT PRODUCT.MODEL, PRINTER.PRICE 
FROM PRODUCT, PRINTER
WHERE MAKER = 'B' AND PRINTER.MODEL = product.MODEL

UNION

SELECT PRODUCT.MODEL, PC.PRICE 
FROM PRODUCT, PC
WHERE MAKER = 'B' AND PC.MODEL = product.MODEL

UNION

SELECT PRODUCT.MODEL, LAPTOP.PRICE 
FROM PRODUCT, LAPTOP
WHERE MAKER = 'B' AND LAPTOP.MODEL = PRODUCT.MODEL

--3. Напишете заявка, която извежда производителите,
--които произвеждат лаптопи, но не произвеждат персонални компютри.
SELECT PRODUCT.MAKER
FROM PRODUCT, LAPTOP
WHERE PRODUCT.MODEL = LAPTOP.MODEL

EXCEPT

SELECT PRODUCT.MAKER
FROM PRODUCT, PC
WHERE PRODUCT.MODEL = pc.MODEL

--4. Напишете заявка, която извежда размерите на тези дискове, 
--които се предлагат в поне два различни персонални компютъра
--(два компютъра с различен код).
SELECT DISTINCT PC1.HD 
FROM PC as PC1, PC as PC2
WHERE PC1.CODE != PC2.CODE AND PC1.HD = PC2.HD

--5. Напишете заявка, която извежда двойките модели на персонални 
--компютри, които имат еднаква честота и памет.
--Двойките трябва да се показват само по веднъж,
--например само (i, j), но не и (j, i).
SELECT PC1.MODEL, PC2.MODEL
FROM PC as PC1, PC as PC2
WHERE PC1.SPEED = PC2.SPEED AND 
PC1.RAM = PC2.RAM AND
PC1.MODEL < PC2.MODEL

--6. Напишете заявка, която извежда производителите на поне два различни
--персонални компютъра с честота поне 400.
SELECT DISTINCT MAKER
FROM PRODUCT, PC as PC1, PC as PC2
WHERE PC1.CODE != PC2.CODE AND
PC1.SPEED >= 400 AND
PC1.MODEL = product.MODEL AND
PC2.MODEL = PC1.MODEL
