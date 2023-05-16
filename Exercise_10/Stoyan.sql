CREATE VIEW flight_info as
SELECT airline_operator, fnumber, COUNT(Booking.customer_id) as customers_count
FROM Flight LEFT JOIN Booking
ON fnumber = flight_number
GROUP BY airline_operator, fnumber

SELECT * FROM flight_info

CREATE VIEW airline_info as
SELECT Customer.FNAME, Customer.LNAME, id FROM Customer
WHERE id IN (SELECT customer_id FROM Booking as b
GROUP BY agency, customer_id
HAVING COUNT(customer_id) >= 
(SELECT TOP 1 COUNT(customer_id) from Booking WHERE Booking.agency=b.agency
GROUP BY agency, customer_id
ORDER BY COUNT(customer_id) DESC))

SELECT * FROM airline_info

CREATE VIEW v_SF_Agencies as
SELECT *
FROM Agency
WHERE city='Sofia'
WITH CHECK OPTION

SELECT * from sofia_agencies

CREATE VIEW v_SF_PH_Agencies as
SELECT *
FROM Agency
WHERE phone is NULL
WITH CHECK OPTION

SELECT * from null_phones

INSERT INTO v_SF_Agencies
VALUES('T1 Tour', 'Bulgaria', 'Sofia','+359');
INSERT INTO v_SF_PH_Agencies
VALUES('T2 Tour', 'Bulgaria', 'Sofia',null);
INSERT INTO v_SF_Agencies
VALUES('T3 Tour', 'Bulgaria', 'Varna','+359');
INSERT INTO v_SF_PH_Agencies
VALUES('T4 Tour', 'Bulgaria', 'Varna',null);
INSERT INTO v_SF_PH_Agencies
VALUES('T4 Tour', 'Bulgaria', 'Sofia','+359');


DROP VIEW v_SF_Agencies
DROP VIEW v_SF_PH_Agencies
DROP VIEW airline_info
DROP VIEW flight_info
