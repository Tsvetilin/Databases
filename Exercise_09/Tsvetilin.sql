--Създайте базата от данни Flights и дефинирайте схемата на релациите, като следвате диаграмата:
CREATE DATABASE Flights
USE Flights

--Airline – код, име, държава
CREATE TABLE Airline(
    code CHAR(2),
    name VARCHAR(50),
    country VARCHAR(50)
)

--Airport – код, име, държава, град
CREATE TABLE Airport(
    code CHAR(3),
    name VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50)
)

--Airplane – код, тип, брой места, година на производство
CREATE TABLE Airplane(
    code CHAR(3),
    type VARCHAR(50),
    seats INT,
    year INT
)

--Flight – номер на полет, код на авиокомпанията, код на летище на излитане, код на
--летище на кацане, час на полета, продължителност на полета, код на самолета
CREATE TABLE Flight(
    flightNumber INT,
    airlineCode CHAR(2),
    departureAirportCode CHAR(3),
    arrivalAirportCode CHAR(3),
    departureTime TIME,
    duration TIME,
    airplaneCode CHAR(3)
)

--Customer – идентификационен номер, име, фамилия, email адрес
CREATE TABLE Customer(
    id INT,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(50)
)

--Agency – име, държава, град, телефонен номер
CREATE TABLE Agency(
    name VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    phoneNumber VARCHAR(50)
)

--Booking – код, име на агенция, код на авиокомпанията, номер на полет,
--идентификационен номер на клиент, дата на резервация, дата на полет, цена,
--състояние (потвърдена/ непотвърдена резервация)
CREATE TABLE Booking(
    code INT,
    agencyName VARCHAR(50),
    airlineCode CHAR(2),
    flightNumber INT,
    customerId INT,
    reservationDate DATE,
    flightDate DATE,
    price DECIMAL(10,2),
    status VARCHAR(50)
)

-- За отделните релации задайте подходящи:
--a) първичен ключ
ALTER TABLE Airline ALTER COLUMN code INT NOT NULL
ALTER TABLE Airline ADD CONSTRAINT PK_Airline PRIMARY KEY (code)

ALTER TABLE Airport ALTER COLUMN code INT NOT NULL
ALTER TABLE Airport ADD CONSTRAINT PK_Airport PRIMARY KEY (code)

ALTER TABLE Airplane ALTER COLUMN code INT NOT NULL
ALTER TABLE Airplane ADD CONSTRAINT PK_Airplane PRIMARY KEY (code)

ALTER TABLE Flight ALTER COLUMN flightNumber INT NOT NULL
ALTER TABLE Flight ADD CONSTRAINT PK_Flight PRIMARY KEY (flightNumber)

ALTER TABLE Customer ALTER COLUMN id INT NOT NULL
ALTER TABLE Customer ADD CONSTRAINT PK_Customer PRIMARY KEY (id)

ALTER TABLE Agency ALTER COLUMN name VARCHAR(50) NOT NULL
ALTER TABLE Agency ADD CONSTRAINT PK_Agency PRIMARY KEY (name)

ALTER TABLE Booking ALTER COLUMN code INT NOT NULL
ALTER TABLE Booking ADD CONSTRAINT PK_Booking PRIMARY KEY (code)

--b) ограничения за референтна цялостност, напр.:
--- код на авиокомпанията от релациите Flight и Booking трябва да съществува в релацията Airline;
ALTER TABLE Flight ADD CONSTRAINT FK_Flight_Airline FOREIGN KEY (airlineCode) REFERENCES Airline(code)

--- код на летище на излитане и код на летище на кацане от релацията Flight трябва да съществува в релацията Airport;
ALTER TABLE Flight ADD CONSTRAINT FK_Flight_Airport FOREIGN KEY (departureAirportCode) REFERENCES Airport(code)

--- код на самолета от релацията Flight трябва да съществува в релацията Airplane;
ALTER TABLE Flight ADD CONSTRAINT FK_Flight_Airplane FOREIGN KEY (airplaneCode) REFERENCES Airplane(code)

--- име на агенция от релацията Booking трябва да съществува в релацията Agency;
ALTER TABLE Booking ADD CONSTRAINT FK_Booking_Agency FOREIGN KEY (agencyName) REFERENCES Agency(name)

--- номер на полет от релацията Booking трябва да съществува в релацията Flight;
ALTER TABLE Booking ADD CONSTRAINT FK_Booking_Flight FOREIGN KEY (flightNumber) REFERENCES Flight(flightNumber)

--- идентификационен номер на клиент от релацията Booking трябва да съществува в релацията Customer;
ALTER TABLE Booking ADD CONSTRAINT FK_Booking_Customer FOREIGN KEY (customerId) REFERENCES Customer(id)

--c) NULL или NOT NULL ограничение
ALTER TABLE Airline ALTER COLUMN name VARCHAR(50) NOT NULL
ALTER TABLE Airline ALTER COLUMN country VARCHAR(50) NOT NULL
ALTER TABLE Airport ALTER COLUMN name VARCHAR(50) NOT NULL
ALTER TABLE Airport ALTER COLUMN country VARCHAR(50) NOT NULL
ALTER TABLE Airport ALTER COLUMN city VARCHAR(50) NOT NULL
ALTER TABLE Airplane ALTER COLUMN type VARCHAR(50) NOT NULL
ALTER TABLE Airplane ALTER COLUMN seats INT NOT NULL
ALTER TABLE Airplane ALTER COLUMN year INT NOT NULL
ALTER TABLE Flight ALTER COLUMN airlineCode CHAR(2) NOT NULL
ALTER TABLE Flight ALTER COLUMN departureAirportCode CHAR(3) NOT NULL
ALTER TABLE Flight ALTER COLUMN arrivalAirportCode CHAR(3) NOT NULL
ALTER TABLE Flight ALTER COLUMN departureTime TIME NOT NULL
ALTER TABLE Flight ALTER COLUMN duration TIME NOT NULL
ALTER TABLE Flight ALTER COLUMN airplaneCode CHAR(3) NOT NULL
ALTER TABLE Customer ALTER COLUMN firstName VARCHAR(50) NOT NULL
ALTER TABLE Customer ALTER COLUMN lastName VARCHAR(50) NOT NULL
ALTER TABLE Customer ALTER COLUMN email VARCHAR(50) NOT NULL
ALTER TABLE Agency ALTER COLUMN name VARCHAR(50) NOT NULL
ALTER TABLE Agency ALTER COLUMN country VARCHAR(50) NOT NULL
ALTER TABLE Agency ALTER COLUMN city VARCHAR(50) NOT NULL
ALTER TABLE Agency ALTER COLUMN phoneNumber VARCHAR(50) NOT NULL
ALTER TABLE Booking ALTER COLUMN agencyName VARCHAR(50) NOT NULL
ALTER TABLE Booking ALTER COLUMN airlineCode CHAR(2) NOT NULL
ALTER TABLE Booking ALTER COLUMN flightNumber INT NOT NULL
ALTER TABLE Booking ALTER COLUMN customerId INT NOT NULL
ALTER TABLE Booking ALTER COLUMN reservationDate DATE NOT NULL
ALTER TABLE Booking ALTER COLUMN flightDate DATE NOT NULL
ALTER TABLE Booking ALTER COLUMN price DECIMAL(10,2) NOT NULL
ALTER TABLE Booking ALTER COLUMN status VARCHAR(50) NOT NULL

--d) UNIQUE ограничение, напр.:
--- името на авиокомпанията от релацията Airline да бъде уникално
ALTER TABLE Airline ADD CONSTRAINT UQ_Airline_Name UNIQUE (name)

--- името на летището от релацията Airport да бъде уникално в рамките на една и съща държава
ALTER TABLE Airport ADD CONSTRAINT UQ_Airport_Name UNIQUE (name, country)

--e) CHECK ограничение, напр.
--- Броят места в самолета от релацията Airplane не трябва да е по-малък или равен на нула.
ALTER TABLE Airplane ADD CONSTRAINT CHK_Airplane_Seats CHECK (seats > 0)

--- Датата на полета от релацията Booking трябва да бъде след или в деня на датата на резервация на билета.
ALTER TABLE Booking ADD CONSTRAINT CHK_Booking_FlightDate CHECK (flightDate >= reservationDate)

--- Проверка за валидност на email-а на клиента от релацията Customer.
--- Валиден email адрес, съдържа символите @ и точка, като задължително има поне шест символа.
ALTER TABLE Customer ADD CONSTRAINT CHK_Customer_Email CHECK (email LIKE '%@%.%' AND LEN(email) >= 6)

--- Състоянието на резервацията от релацията Booking може да е 0 или 1.
ALTER TABLE Booking ADD CONSTRAINT CHK_Booking_Status CHECK (status IN ('0', '1'))