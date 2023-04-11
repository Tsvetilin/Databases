--4. Използвайте две INSERT заявки. Съхранете в базата данни факта,
--че персонален компютър модел 1100 е направен от производителя C,
--има процесор 2400 MHz, RAM 2048 MB, твърд диск 500 GB,
--52x оптично дисково устройство и струва $299.
--Нека новият компютър има код 12. Забележка: модел и CD са от тип низ.
INSERT INTO PC(CODE, MODEL, SPEED, RAM, HD, CD, PRICE)
VALUES(12, '1100', 2400, 2048, '500', 52, 299)
    INSERT INTO PRODUCT(MODEL, MAKER, TYPE)
VALUES ('1100', 'C', 'PC')

--5. Да се изтрие наличната информация в таблицата PC
--за компютри модел 1100.
DELETE FROM PC
WHERE PC.MODEL = '1100'

--6. Да се изтрият от таблицата Laptop всички лаптопи,
--направени от производител, който не произвежда принтери.
DELETE FROM LAPTOP
WHERE LAPTOP.MODEL IN (SELECT MODEL FROM PRODUCT WHERE PRODUCT.TYPE = 'Printer')

--7. Производител А купува производител B.
--На всички продукти на В променете производителя да бъде А.
UPDATE PRODUCT
SET MAKER = 'A'
WHERE MAKER = 'B'

--8. Да се намали наполовина цената на всеки компютър и
--да се добавят по 20 GB към всеки твърд диск.
UPDATE PC
SET PC.PRICE = (PC.PRICE * 2),
    PC.HD = (PC.HD + 20)

--9. За всеки лаптоп от производител B добавете по един инч
--към диагонала на екрана.
UPDATE LAPTOP
SET LAPTOP.SCREEN = (LAPTOP.SCREEN + 1)
WHERE LAPTOP.MODEL IN
      (SELECT PRODUCT.MODEL FROM PRODUCT WHERE PRODUCT.TYPE = 'Laptop'
                                           AND PRODUCT.MAKER = 'B')