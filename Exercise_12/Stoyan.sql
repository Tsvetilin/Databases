CREATE DATABASE FurnitureCompany

USE FurnitureCompany

CREATE TABLE CUSTOMER(
                         Customer_ID INT NOT NULL IDENTITY PRIMARY KEY,
                         Customer_Name VARCHAR(50) NOT NULL,
                         Customer_Address VARCHAR(50),
                         Customer_City VARCHAR(50),
                         City_Code INT
);

INSERT INTO CUSTOMER VALUES
                         ('Иван Петров', 'ул. Лавеле 8', 'София', '1000'),
                         ('Камелия Янева', 'ул. Иван Шишман 3', 'Бургас', '8000'),
                         ('Васил Димитров', 'ул. Абаджийска 87', 'Пловдив', '4000'),
                         ('Ани Милева', 'бул. Владислав Варненчик 56', 'Варна','9000');

CREATE TABLE ORDER_T(
                        Order_ID INT NOT NULL PRIMARY KEY,
                        Order_DATE DATE NOT NULL,
                        Customer_ID INT NOT NULL
                            CONSTRAINT FK_CustID FOREIGN KEY(Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

INSERT INTO ORDER_T VALUES
                        (100, '2013-01-05', 1),
                        (101, '2013-12-07', 2),
                        (102, '2014-10-03', 3),
                        (103, '2014-10-08', 2),
                        (104, '2015-10-05', 1),
                        (105, '2015-10-05', 4),
                        (106, '2015-10-06', 2),
                        (107, '2016-01-06', 1);

CREATE TABLE PRODUCT (
                         Product_ID INT NOT NULL PRIMARY KEY,
                         Product_Description VARCHAR(50),
                         Product_Finish VARCHAR(50),
                         Standart_Price DECIMAL,
                         Product_Line_ID INT NOT NULL,
                         CHECK (Product_Finish IN ('череша', 'естествен ясен', 'бял ясен', 'червен дъб', 'естествен дъб', 'орех'))
);

INSERT INTO PRODUCT VALUES
                        (1000, 'офис бюро', 'череша', 195, 10),
                        (1001, 'директорско бюро', 'червен дъб', 250, 10),
                        (2000, 'офис стол', 'череша', 75, 20),
                        (2001, 'директорски стол', 'естествен дъб', 129, 20),
                        (3000, 'етажерка за книги', 'естествен ясен', 85, 30),
                        (4000, 'настолна лампа', 'естествен ясен', 35, 40);
CREATE TABLE ORDER_LINE (
                            Order_ID INT NOT NULL,
                            Product_ID INT NOT NULL,
                            Ordered_Quantity INT NOT NULL
                                CONSTRAINT FK_OrderID FOREIGN KEY(Order_ID) REFERENCES ORDER_T(Order_ID),
                            CONSTRAINT FK_ProductID FOREIGN KEY(Product_ID) REFERENCES PRODUCT(Product_ID)
);

INSERT INTO ORDER_LINE VALUES
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

    USE PC

--Да се напише заявка, която извежда производителите както на принтери, така и на лаптопи.
--Забележка: Предложете 2 варианта за решаване на задачата - с подзаявка и със сечение.

SELECT DISTINCT PRODUCT.MAKER
FROM PRODUCT
WHERE PRODUCT.MAKER IN (SELECT PRODUCT.MAKER FROM PRODUCT JOIN LAPTOP ON PRODUCT.MODEL = LAPTOP.MODEL)
  AND PRODUCT.MAKER IN (SELECT PRODUCT.MAKER FROM PRODUCT JOIN PRINTER ON PRODUCT.MODEL = PRINTER.MODEL)

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