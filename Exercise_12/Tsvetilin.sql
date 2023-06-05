--Като използвате диаграмата по-долу, създайте базата от данни FurnitureCompany и
--дефинирайте схемата на всяка релация. Добавете подходящи ограничения (PK, FK и др.).
--Забележки:
--- Customer_ID от таблицата Customer се въвежда автоматично.
--- Product_Finish от таблицата Product може да приема стойности: череша, естествен ясен, бял ясен,
--червен дъб, естествен дъб, орех.

CREATE DATABASE FurnitureCompany

USE FurnitureCompany

CREATE TABLE CUSTOMER
(
     Customer_ID INT NOT NULL IDENTITY PRIMARY KEY,
     Customer_Name VARCHAR(50) NOT NULL,
     Customer_Address VARCHAR(50),
     Customer_City VARCHAR(50),
     City_Code INT
);

CREATE TABLE ORDER_T
(
     Order_ID INT NOT NULL PRIMARY KEY,
     Order_DATE DATE NOT NULL,
     Customer_ID INT NOT NULL
          CONSTRAINT FK_CustID FOREIGN KEY(Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

CREATE TABLE PRODUCT
(
     Product_ID INT NOT NULL PRIMARY KEY,
     Product_Description VARCHAR(50),
     Product_Finish VARCHAR(50),
     Standart_Price DECIMAL,
     Product_Line_ID INT NOT NULL,
     CHECK (Product_Finish IN ('череша', 'естествен ясен', 'бял ясен', 'червен дъб', 'естествен дъб', 'орех'))
);


CREATE TABLE ORDER_LINE
(
     Order_ID INT NOT NULL,
     Product_ID INT NOT NULL,
     Ordered_Quantity INT NOT NULL
          CONSTRAINT FK_OrderID FOREIGN KEY(Order_ID) REFERENCES ORDER_T(Order_ID),
     CONSTRAINT FK_ProductID FOREIGN KEY(Product_ID) REFERENCES PRODUCT(Product_ID)
);

--Вмъкнете минимум следните данни:
INSERT INTO ORDER_T
VALUES
     (100, '2013-01-05', 1),
     (101, '2013-12-07', 2),
     (102, '2014-10-03', 3),
     (103, '2014-10-08', 2),
     (104, '2015-10-05', 1),
     (105, '2015-10-05', 4),
     (106, '2015-10-06', 2),
     (107, '2016-01-06', 1);

INSERT INTO CUSTOMER
VALUES
     ('Иван Петров', 'ул. Лавеле 8', 'София', '1000'),
     ('Камелия Янева', 'ул. Иван Шишман 3', 'Бургас', '8000'),
     ('Васил Димитров', 'ул. Абаджийска 87', 'Пловдив', '4000'),
     ('Ани Милева', 'бул. Владислав Варненчик 56', 'Варна', '9000');

     INSERT INTO PRODUCT
VALUES
     (1000, 'офис бюро', 'череша', 195, 10),
     (1001, 'директорско бюро', 'червен дъб', 250, 10),
     (2000, 'офис стол', 'череша', 75, 20),
     (2001, 'директорски стол', 'естествен дъб', 129, 20),
     (3000, 'етажерка за книги', 'естествен ясен', 85, 30),
     (4000, 'настолна лампа', 'естествен ясен', 35, 40);

INSERT INTO ORDER_LINE
VALUES
     (100, 4000, 1),
     (101, 1000, 2),
     (101, 2000, 2),
     (102, 3000, 1),
     (102, 2000, 1),
     (106, 4000, 1),
     (103, 4000, 1),
     (104, 4000, 1),
     (105, 4000, 1),
     (107, 4000, 1);

--Напишете заявка, която извежда id и описание на продукт, както и колко пъти е бил поръчан,
--само за тези продукти, които са били поръчвани

SELECT Product.Product_ID, Product_Description, COUNT(ORDER_T.Order_ID) as Product_Count
FROM (PRODUCT JOIN ORDER_LINE ON
        PRODUCT.Product_ID = ORDER_LINE.Product_ID)
     JOIN ORDER_T ON
        ORDER_T.Order_ID = ORDER_LINE.Order_ID
GROUP BY Product.Product_ID, Product.Product_Description

--Напишете заявка, която извежда id и описание на продукт, както и поръчано количество, за
--всички продукти.

SELECT Product.Product_ID, Product_Description, COUNT(ORDER_T.Order_ID) as Product_Count
FROM (PRODUCT LEFT JOIN ORDER_LINE ON
        PRODUCT.Product_ID = ORDER_LINE.Product_ID)
     LEFT JOIN ORDER_T ON
        ORDER_T.Order_ID = ORDER_LINE.Order_ID
GROUP BY Product.Product_ID, Product.Product_Description

--Напишете заявка, която извежда име на клиента и обща стойност на направените от него
--поръчки, само за клиентите с поръчки

SELECT CUSTOMER.Customer_Name, SUM(PRODUCT.Standart_Price)
FROM CUSTOMER JOIN ORDER_T ON
        CUSTOMER.Customer_ID = ORDER_T.Customer_ID
     JOIN ORDER_LINE ON
        ORDER_T.Order_ID = ORDER_LINE.Order_ID
     JOIN PRODUCT ON
        PRODUCT.Product_ID = ORDER_LINE.Product_ID
GROUP BY CUSTOMER.Customer_Name


--За базата от данни PC
USE PC

--Да се напише заявка, която извежда производителите както на принтери, така и на лаптопи.
--Забележка: Предложете 2 варианта за решаване на задачата - с подзаявка и със сечение.

SELECT DISTINCT PRODUCT.MAKER
FROM PRODUCT
WHERE PRODUCT.MAKER IN (SELECT PRODUCT.MAKER
     FROM PRODUCT JOIN LAPTOP ON PRODUCT.MODEL = LAPTOP.MODEL)
     AND PRODUCT.MAKER IN (SELECT PRODUCT.MAKER
     FROM PRODUCT JOIN PRINTER ON PRODUCT.MODEL = PRINTER.MODEL)

     SELECT DISTINCT PRODUCT.MAKER
     FROM PRODUCT JOIN LAPTOP ON PRODUCT.MODEL = LAPTOP.MODEL

INTERSECT

     SELECT DISTINCT PRODUCT.MAKER
     FROM PRODUCT JOIN PRINTER ON PRODUCT.MODEL = PRINTER.MODEL

--Намалете с 5% цената на онези персонални компютри, които имат производители,
--такива че средната цена на продаваните от тях принтери е над 800

UPDATE PC
SET PC.price = 0.95 * PC.price
WHERE PC.model IN
      (SELECT PC.model
FROM PC
     JOIN PRODUCT
     ON PRODUCT.model = PC.model
WHERE PRODUCT.maker IN (
           SELECT PRODUCT.maker as maker
FROM PRODUCT JOIN PRINTER
     ON product.model = printer.model
GROUP BY PRODUCT.maker
HAVING AVG(Price) > 800)
      )

--Намерете за всеки размер на твърд диск на персонален компютър между 10 и 30 GB, найниската цена за съответния размер.
SELECT MIN(PRICE)
FROM PC
GROUP BY HD
HAVING HD >= 10 AND HD <= 30

-- За базата от данни Ships
USE Ships

--Съставете изгледи, съдържащи имената на битките, които са по-мащабни от битката при
--Guadalcanal. Под по-мащабна битка се разбира:
--a) битка с повече участващи кораби;
--b) битка с повече участващи страни.
--Като използвате изгледите, напишете заявки, които извеждат съответните битки.
GO
CREATE VIEW guadalcanal_countries
AS
     SELECT COUNT(COUNTRY) as Countries_Count
     FROM CLASSES
          JOIN SHIPS
          ON CLASSES.CLASS = SHIPS.CLASS
          JOIN OUTCOMES
          ON SHIPS.NAME = OUTCOMES.SHIP
          JOIN BATTLES
          ON BATTLES.NAME = OUTCOMES.BATTLE
     GROUP BY BATTLES.NAME
     HAVING BATTLES.NAME = 'Guadalcanal'
GO

CREATE VIEW more_countries_info
AS
     SELECT BATTLES.NAME
     FROM CLASSES
          JOIN SHIPS
          ON CLASSES.CLASS = SHIPS.CLASS
          JOIN OUTCOMES
          ON SHIPS.NAME = OUTCOMES.SHIP
          JOIN BATTLES
          ON BATTLES.NAME = OUTCOMES.BATTLE
     GROUP BY BATTLES.NAME
     HAVING COUNT(COUNTRY) > (SELECT *
     FROM guadalcanal_countries)
GO

CREATE VIEW guadalcanal_ships
AS
     SELECT COUNT(SHIPS.NAME) as Countries_Count
     FROM CLASSES
          JOIN SHIPS
          ON CLASSES.CLASS = SHIPS.CLASS
          JOIN OUTCOMES
          ON SHIPS.NAME = OUTCOMES.SHIP
          JOIN BATTLES
          ON BATTLES.NAME = OUTCOMES.BATTLE
     GROUP BY BATTLES.NAME
     HAVING BATTLES.NAME = 'Guadalcanal'
GO

CREATE VIEW more_ships_info
AS
     SELECT BATTLES.NAME, COUNT(SHIPS.NAME)
     FROM CLASSES
          JOIN SHIPS
          ON CLASSES.CLASS = SHIPS.CLASS
          JOIN OUTCOMES
          ON SHIPS.NAME = OUTCOMES.SHIP
          JOIN BATTLES
          ON BATTLES.NAME = OUTCOMES.BATTLE
     GROUP BY BATTLES.NAME
     HAVING COUNT(SHIPS.NAME) > (SELECT *
     FROM guadalcanal_ships)
GO

--Изтрийте от таблицата Outcomes всички битки, в които е участвал един единствен кораб.

DELETE FROM OUTCOMES
WHERE OUTCOMES.BATTLE IN (SELECT BATTLES.NAME
FROM BATTLES JOIN OUTCOMES
     ON BATTLES.NAME = OUTCOMES.BATTLE
GROUP BY BATTLES.NAME
HAVING COUNT(SHIP)=1
)

--Изтрийте от таблицата Outcomes всички записи, в които участва кораб, потапян поне два
--пъти и резултатът от съответната битка е 'sunk'.
--Забележка: Преди това може да вмъкнете следните кортежи, за да проверите по-лесно как работи
--написаната заявка.
--INSERT INTO outcomes VALUES ('Missouri','Surigao Strait', 'sunk'),
--('Missouri','North Cape', 'sunk'),
--('Missouri','North Atlantic', 'ok');
DELETE FROM OUTCOMES
WHERE OUTCOMES.SHIP IN (SELECT OUTCOMES.SHIP
FROM OUTCOMES
WHERE result='sunk'
GROUP BY OUTCOMES.SHIP
HAVING COUNT(RESULT)=2
)

--Изведете всички битки, в които са участвали същите страни, като страните в битката при
--Guadalcanal.
--Възможен вариант за решаване: Създайте изглед, съдържащ всички битки и участващите в тях
--страни. След това напишете заявка, като използвате и изгледа.

GO
CREATE VIEW battle_countries
AS
     SELECT OUTCOMES.BATTLE as battle, CLASSES.COUNTRY as country
     FROM OUTCOMES JOIN SHIPS
          ON OUTCOMES.SHIP = SHIPS.NAME
          JOIN CLASSES
          ON CLASSES.CLASS = SHIPS.CLASS
GO

SELECT battle
FROM battle_countries
WHERE country = (SELECT DISTINCT country
from battle_countries
where battle = 'Guadalcanal')

--Намерете всяка страна в колко битки е участвала.
--Забележка: Ако страната не е участвала в нито една битка (защото (а) няма кораби или (б) има
--кораби, но те не са участвали в битка), то трябва да се покаже в резултата с брой кораби 0.

GO
CREATE VIEW countries_ships
AS
     SELECT DISTINCT CLASSES.COUNTRY as country, SHIPS.NAME as ship
     FROM CLASSES LEFT JOIN SHIPS
          ON CLASSES.CLASS = SHIPS.CLASS
GO

CREATE VIEW ships_battles
AS
     SELECT DISTINCT SHIPS.NAME as ship
     FROM SHIPS JOIN OUTCOMES
          ON SHIPS.NAME = OUTCOMES.SHIP
GO

SELECT country, COUNT(ships_battles.ship)
FROM countries_ships LEFT JOIN ships_battles
     ON countries_ships.ship = ships_battles.ship
GROUP BY country
