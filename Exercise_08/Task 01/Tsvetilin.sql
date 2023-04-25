--Дефинирайте следните релации:

--Product (maker, model, type), където:
-- модел е низ от точно 4 символа,
-- производител е низ от точно 1 символ,
-- тип е низ до 7 символа;
CREATE TABLE Product
(
    maker CHAR(1),
    model CHAR(4),
    type VARCHAR(7)
)

--Printer (code, model, price), където:
-- код е цяло число,
-- модел е низ от точно 4 символа,
-- цена с точност до два знака след десетичната запетая;
CREATE TABLE Printer
(
    code INT,
    model CHAR(4),
    price DECIMAL(10,2)
)

-- Добавете към релацията Printer атрибути:
-- type - низ до 6 символа (забележка: type може да приема стойност 'laser', 'matrix' или 'jet'),
-- color - низ от точно 1 символ, стойност по подразбиране 'n' (забележка: color може да приема стойност 'y' или 'n').
ALTER TABLE Printer ADD type VARCHAR(6) CHECK (type IN('laser', 'matrix', 'jet')),
                        color CHAR(1) DEFAULT 'n' CHECK (color IN('y', 'n'))

-- Напишете заявка, която премахва атрибута price от релацията Printer.
ALTER TABLE Printer DROP COLUMN price

-- Изтрийте релациите, които сте създали в Задача 1.
DROP TABLE Printer
DROP TABLE Product
