--1. Напишете заявка, която извежда всички модели лаптопи, за които се
--предлагат както разновидности с 15" екран, така и с 11" екран.
SELECT LAPTOP.MODEL
FROM LAPTOP
GROUP BY LAPTOP.MODEL, LAPTOP.SCREEN
HAVING LAPTOP.SCREEN = 15

INTERSECT

SELECT LAPTOP.MODEL
FROM LAPTOP
GROUP BY LAPTOP.MODEL, LAPTOP.SCREEN
HAVING LAPTOP.SCREEN = 11

--2. Да се изведат различните модели компютри, чиято цена е по-ниска от най-евтиния
--лаптоп, произвеждан от същия производител.
SELECT DISTINCT PC.MODEL
FROM PC JOIN PRODUCT AS P
             ON PC.MODEL = P.MODEL
GROUP BY PC.MODEL, P.MAKER, PC.PRICE
HAVING PC.PRICE < (SELECT TOP 1 LAPTOP.PRICE
                   FROM LAPTOP JOIN PRODUCT
                                    ON LAPTOP.MODEL = PRODUCT.MODEL
                   GROUP BY PRODUCT.MAKER, LAPTOP.PRICE
                   HAVING PRODUCT.MAKER = P.MAKER
                   ORDER BY LAPTOP.PRICE)

--3. Един модел компютри може да се предлага в няколко разновидности с
--различна цена. Да се изведат тези модели компютри, чиято средна цена (на
--различните му разновидности) е по-ниска от най-евтиния лаптоп, произвеждан
--от същия производител.
SELECT PC.MODEL, AVG(PC.PRICE)
FROM PC JOIN PRODUCT AS P
             ON PC.MODEL = P.MODEL
GROUP BY PC.MODEL, P.MAKER
HAVING AVG(PC.PRICE) < (SELECT TOP 1 LAPTOP.PRICE
                        FROM LAPTOP JOIN PRODUCT
                                         ON LAPTOP.MODEL = PRODUCT.MODEL
                        GROUP BY PRODUCT.MAKER, LAPTOP.PRICE
                        HAVING PRODUCT.MAKER = P.MAKER
                        ORDER BY LAPTOP.PRICE)

--4. Напишете заявка, която извежда за всеки компютър код на продукта,
--производител и брой компютри, които имат цена, по-голяма или равна на
--неговата.
SELECT COMP.CODE, PRODUCT.MAKER, COMP.PRICE,
       (SELECT COUNT(PC.CODE) FROM PC WHERE PC.PRICE >= COMP.PRICE)
FROM PC AS COMP JOIN PRODUCT
                     ON COMP.MODEL = PRODUCT.MODEL
GROUP BY COMP.CODE, PRODUCT.MAKER, COMP.PRICE
ORDER BY COMP.PRICE