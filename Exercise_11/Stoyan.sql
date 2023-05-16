ALTER TABLE Flight
ADD numpass int;

ALTER TABLE Agency
ADD num_book int;

UPDATE Flight
SET numpass = 0
WHERE numpass IS NULL;

UPDATE Agency
SET num_book = 0
WHERE num_book IS NULL;

SELECT * FROM Agency

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

SELECT * FROM Booking

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
