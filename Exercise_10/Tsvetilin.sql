--Изгледи 

--За базата от данни Flights: 

--1. Създайте изглед, който извежда име на авиокомпания оператор на полета, номер на полет 
--и брой пътници, потвърдили резервация за този полет. Тествайте изгледa. 
CREATE VIEW flight_info 
AS
SELECT airline_operator, fnumber, COUNT(Booking.customer_id) as customers_count
FROM Flight LEFT JOIN Booking
ON fnumber = flight_number
GROUP BY airline_operator, fnumber
GO

SELECT * FROM flight_info
GO


--2. Създайте  изглед,  който  за  всяка  агенция  извежда  името  на  клиента  с  най-много  резервации
CREATE VIEW airline_info 
AS
SELECT Customer.FNAME, Customer.LNAME, id FROM Customer
WHERE id IN (SELECT customer_id FROM Booking as b
GROUP BY agency, customer_id
HAVING COUNT(customer_id) >= 
(SELECT TOP 1 COUNT(customer_id) from Booking WHERE Booking.agency=b.agency
GROUP BY agency, customer_id
ORDER BY COUNT(customer_id) DESC))
GO

SELECT * FROM airline_info
GO
--3. Създайте изглед за таблицата Agencies, който извежда всички данни за агенциите от град  София.
CREATE VIEW v_SF_Agencies 
AS
SELECT *
FROM Agency
WHERE city='Sofia'
WITH CHECK OPTION
GO

SELECT * from sofia_agencies
GO

--4. Създайте изглед за таблицата Agencies, който извежда всички данни за агенциите, такива 
--че телефонните номера на тези агенции да имат стойност NULL. 
CREATE VIEW v_SF_PH_Agencies as
SELECT *
FROM Agency
WHERE phone is NULL
WITH CHECK OPTION
GO

SELECT * from null_phones
GO

-- 7. Изтрийте създадените изгледи. 

DROP VIEW v_SF_Agencies
DROP VIEW v_SF_PH_Agencies
DROP VIEW airline_info
DROP VIEW flight_info


--Индекси 
-- 8. Създайте подходящ/и индекс/и върху таблицата Product от базата от данни PC. 
-- 9. Създайте подходящи индекси върху таблиците Classes, Ships, Battles, Outcomes от базата  от данни Ships.
-- 10. Изтрийте създадените индекси. 














