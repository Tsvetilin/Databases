--Извършете следните модификации в базата от данни PC:
USE pc

--1. Използвайте две INSERT заявки. Съхранете в базата данни факта, че персонален компютър
--модел 1100 е направен от производителя C, има процесор 2400 MHz, RAM 2048 MB, твърд диск
--500 GB, 52x оптично дисково устройство и струва $299. Нека новият компютър има код 12.
--Забележка: модел и CD са от тип низ.
INSERT INTO dbo.pc(code,model,speed,ram,hd,cd,price) VALUES(12, '1100', 2400,2048,500,'52x',299)
INSERT INTO dbo.product(type,maker,model) VALUES('pc', 'C', '1100')

--2. Да се изтрие наличната информация в таблицата PC за компютри модел 1100.
DELETE FROM dbo.pc WHERE dbo.pc.model='1100'

--3. Да се изтрият от таблицата Laptop всички лаптопи, направени от производител, който не произвежда принтери.
DELETE FROM dbo.laptop 
WHERE dbo.laptop.model NOT IN 
	(SELECT dbo.product.model FROM dbo.product WHERE dbo.product.maker NOT IN 
		(SELECT dbo.product.maker FROM dbo.product JOIN dbo.printer ON dbo.printer.model=dbo.product.model))

--4. Производител А купува производител B. На всички продукти на В променете производителя да бъде А.
UPDATE dbo.product SET dbo.product.maker='A' WHERE dbo.product.maker='B'

--5. Да се намали наполовина цената на всеки компютър и да се добавят по 20 GB към всеки твърд диск.
UPDATE dbo.pc SET dbo.pc.price=dbo.pc.price/2, dbo.pc.hd=dbo.pc.hd+20

--6. За всеки лаптоп от производител B добавете по един инч към диагонала на екрана.
UPDATE dbo.laptop
SET dbo.laptop.screen=dbo.laptop.screen+1
WHERE dbo.laptop.model IN (SELECT dbo.product.model FROM dbo.product WHERE dbo.product.maker='B')  
