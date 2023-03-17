--1. Напишете заявка, която извежда производител, модел и тип на продукт
--за тези производители, за които съответният продукт не се продава
--(няма го в таблиците PC, Laptop или Printer)
SELECT P.MAKER, P.MODEL, P.TYPE
FROM PRODUCT AS P
WHERE P.MODEL NOT IN (SELECT LAPTOP.MODEL FROM LAPTOP) AND
        P.MODEL NOT IN (SELECT PC.MODEL FROM PC) AND
        P.MODEL NOT IN (SELECT PRINTER.MODEL FROM PRINTER)

--2. Намерете всички производители, които правят както лаптопи, така и
--принтери.
    (SELECT P.MAKER
     FROM PRODUCT P JOIN LAPTOP ON
             P.MODEL = LAPTOP.MODEL)

     INTERSECT

     (SELECT P.MAKER
     FROM PRODUCT P JOIN PRINTER ON
         P.MODEL = PRINTER.MODEL)
--3. Намерете размерите на тези твърди дискове, които се появяват в два
--или повече модела лаптопи.
SELECT DISTINCT L1.HD
FROM LAPTOP AS L1, LAPTOP AS L2
WHERE L1.HD = L2.HD AND L1.MODEL != L2.MODEL

--4. Намерете всички модели персонални компютри, които нямат регистриран
--производител.
SELECT PRODUCT.MODEL
FROM PRODUCT LEFT JOIN PC ON
        PRODUCT.MODEL = PC.MODEL
WHERE PC.MODEL = NULL
