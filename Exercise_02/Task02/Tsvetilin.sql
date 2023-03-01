--II.За базата от данни PC
USE pc

--1. Напишете заявка, която извежда производителя и честотата на лаптопите с размер на диска поне 9 GB.
SELECT dbo.product.maker, dbo.laptop.speed
FROM dbo.product, dbo.laptop
WHERE dbo.laptop.hd > 9
	AND dbo.product.model=dbo.laptop.model

--2. Напишете заявка, която извежда модел и цена на продуктите, произведени от производител с име B.
SELECT dbo.product.model, dbo.laptop.price
FROM dbo.product, dbo.laptop
WHERE dbo.product.maker='B'
	AND dbo.product.model=dbo.laptop.model
UNION
SELECT dbo.product.model, dbo.pc.price
FROM dbo.product, dbo.pc
WHERE dbo.product.maker='B'
	AND dbo.product.model=dbo.pc.model
UNION
SELECT dbo.product.model, dbo.printer.price
FROM dbo.product, dbo.printer
WHERE dbo.product.maker='B'
	AND dbo.product.model=dbo.printer.model

--3. Напишете заявка, която извежда производителите, които произвеждат лаптопи, но не произвеждат персонални компютри.
SELECT dbo.product.maker
FROM dbo.product, dbo.laptop
WHERE dbo.product.model = dbo.laptop.model
EXCEPT
SELECT dbo.product.maker
FROM dbo.product, dbo.pc
WHERE dbo.product.model = dbo.pc.model

--4. Напишете заявка, която извежда размерите на тези дискове, които се предлагат в поне два различни персонални компютъра (два компютъра с различен код).
SELECT DISTINCT PC1.hd
FROM dbo.pc AS PC1, dbo.pc AS PC2
WHERE PC1.code != PC2.code AND PC1.hd=PC2.hd

--5. Напишете заявка, която извежда двойките модели на персонални компютри, които имат еднаква честота и памет. Двойките трябва да се показват само по веднъж, например само (i, j), но не и (j, i).
SELECT PC1.model, PC2.model
FROM dbo.pc AS PC1, dbo.pc AS PC2
WHERE PC1.speed=PC2.speed AND PC1.ram=PC2.ram AND PC1.model!= PC2.model
EXCEPT
SELECT PC1.model, PC2.model
FROM dbo.pc AS PC1, dbo.pc AS PC2
WHERE PC1.speed=PC2.speed AND PC1.ram=PC2.ram AND PC1.model!= PC2.model AND PC1.model > PC2.model

--6. Напишете заявка, която извежда производителите на поне два различни персонални компютъра с честота поне 400.
SELECT DISTINCT PC1PRODUCT.maker
FROM dbo.pc AS PC1, dbo.pc AS PC2, dbo.product AS PC1PRODUCT, dbo.product AS PC2PRODUCT
WHERE PC1.code!= PC2.code 
	AND PC1.model = PC1PRODUCT.model 
	AND PC2.model = PC2PRODUCT.model 
	AND PC1PRODUCT.maker = PC2PRODUCT.maker 
	AND PC1.speed>=400 
	AND PC2.speed>=400
    