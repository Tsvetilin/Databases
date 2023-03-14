--II. За базата от данни PC
USE pc

--1. Напишете заявка, която извежда производител, модел и тип на продукт за тези производители, за които съответният продукт не се продава 
--(няма го в таблиците PC, Laptop или Printer)
SELECT dbo.product.maker, dbo.product.model, dbo.product.type
FROM dbo.product LEFT JOIN dbo.laptop ON dbo.laptop.model = dbo.product.model
		LEFT JOIN dbo.pc ON dbo.pc.model = dbo.product.model
		LEFT JOIN dbo.printer ON dbo.printer.model = dbo.product.model
WHERE dbo.laptop.code IS NULL AND dbo.pc.code IS NULL AND dbo.printer.code IS NULL

--2. Намерете всички производители, които правят както лаптопи, така и принтери.
SELECT dbo.product.maker
FROM dbo.product JOIN dbo.laptop ON dbo.laptop.model = dbo.product.model
INTERSECT
SELECT dbo.product.maker
FROM dbo.product JOIN dbo.printer ON dbo.printer.model = dbo.product.model

--3. Намерете размерите на тези твърди дискове, които се появяват в два или повече модела лаптопи.
SELECT DISTINCT L.hd
FROM dbo.laptop AS L
WHERE (SELECT COUNT(dbo.laptop.code) FROM dbo.laptop WHERE dbo.laptop.hd = L.hd) > 1

-- or 

SELECT DISTINCT L1.hd
FROM dbo.laptop AS L1 JOIN dbo.laptop AS L2 ON L1.hd=L2.hd
WHERE L1.code != L2.code

--4. Намерете всички модели персонални компютри, които нямат регистриран производител.
SELECT dbo.product.maker
FROM dbo.pc LEFT JOIN dbo.product ON dbo.pc.model = dbo.product.model
WHERE dbo.product.maker IS NULL
