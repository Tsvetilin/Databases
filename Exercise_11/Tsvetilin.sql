--Като използвате базата от данни Flights:
USE Flights

--1. Добавете нова колона num_pass към таблицата Flights, която ще съдържа броя на
--пътниците, потвърдили резервация за съответния полет.
ALTER TABLE Flight
ADD numpass int;

UPDATE Flight
SET numpass = 0
WHERE numpass IS NULL;

--2. Добавете нова колона num_book към таблицата Agencies, която ще съдържа броя на
--резервациите към съответната агенция.
ALTER TABLE Agency
ADD num_book int;

UPDATE Agency
SET num_book = 0
WHERE num_book IS NULL;

GO

--3. Създайте тригер за таблицата Bookings, който да се задейства при вмъкване на
--резервация в таблицата и да увеличава с единица броя на пътниците, потвърдили
--резервация за таблицата Flights, както и броя на резервациите към съответната агенция.

CREATE TRIGGER trg_insert_booking
ON Booking AFTER INSERT
AS
BEGIN
UPDATE Flight
SET numpass=(numpass+1)
WHERE fnumber IN (SELECT fnumber FROM inserted);
UPDATE Agency
SET num_book=(num_book+1)
WHERE name IN (SELECT name FROM inserted);
END

GO

--4. Създайте тригер за таблицата Bookings, който да се задейства при изтриване на
--резервация в таблицата и да намалява с единица броя на пътниците, потвърдили
--резервация за таблицата Flights, както и броя на резервациите към съответната агенция.

CREATE TRIGGER trg_delete_booking
ON Booking AFTER DELETE
AS
BEGIN
UPDATE Flight
SET numpass=(numpass-1)
WHERE fnumber IN (SELECT fnumber FROM deleted);
UPDATE Agency
SET num_book=(num_book-1)
WHERE name IN (SELECT name FROM deleted);
END

GO

--5. Създайте тригер за таблицата Bookings, който да се задейства при обновяване на
--резервация в таблицата и да увеличава или намалява с единица броя на пътниците,
--потвърдили резервация за таблицата Flights при промяна на статуса на резервацията.

CREATE TRIGGER trg_update_booking
ON Booking AFTER UPDATE
AS
BEGIN
UPDATE Flight
SET numpass=(numpass-1)
WHERE fnumber IN (SELECT flight_number FROM deleted WHERE status=1) and 
fnumber IN (SELECT flight_number FROM inserted WHERE status=0);
UPDATE Flight
SET numpass=(numpass+1)
WHERE fnumber IN (SELECT flight_number FROM deleted WHERE status=0) and 
fnumber IN (SELECT flight_number FROM inserted WHERE status=1);
END

GO