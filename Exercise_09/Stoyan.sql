-- 1) Create the FLights database and add necessary constraints:
--	a) Primary Keys
--	b) Foreign Keys
--	c) Null and Not Null
--	d) Unique
--	e) Check
create table Airline(
	code char(6) primary key,
	name varchar(20) unique not null,
	country varchar(50) not null
);

create table Airport(
	code char(6) primary key,
	name varchar(50) not null,
	city varchar(50),
	country varchar(50) not null,
	unique(name, country)
);

create table Airplane(
	code char(6) primary key,
	type varchar(30),
	seats int not null,
	year integer not null check(year > 0),
	check(seats > 0)
);

create table Flight(
	fnumber char(14) primary key,
	airline_operator char(6) not null foreign key references Airline(code),
	dep_airport char(6) not null foreign key references Airport(code),
	arr_airport char(6) not null foreign key references Airport(code),
	airplane char(6) not null foreign key references Airplane(code),
	flight_time time,
	flight_duration int
);

create table Customer(
	id int primary key,
	FNAME varchar(100),
	LNAME varchar(100),
	email varchar(50),
	check(email like '%@__%.%')
);

create table Agency(
	name varchar(100) not null primary key,
	country varchar(50),
	city varchar(50),
	phone varchar(50)
);

create table Booking(
	code char(10) primary key,
	agency varchar(100) foreign key references Agency(name),
	airline_code char(6) not null foreign key references Airline(code),
	flight_number char(14) foreign key references Flight(fnumber),
	customer_id int not null foreign key references Customer(id),
	booking_date date default GETDATE(),
	flight_date date,
	price decimal(10,2) not null,
	status int,
	check(status in (0,1)),
	check(flight_date>=booking_date)
);

-- Example data for the Database
INSERT INTO AIRLINE(code, name,	country)
VALUES ('AZ', 'Alitalia', 'Italy'),
('BA', 'British Airways', 'United Kingdom'),
('LH', 'Lufthansa', 'Germany'),
('SR', 'Swissair', 'Switzerland'),
('FB', 'Bulgaria Air', 'Bulgaria'),
('AF', 'Air France', 'France'),
('TK', 'Turkish Airlines', 'Turkey'),
('AA', 'American Airlines', 'United States');

INSERT INTO AIRPORT(code, name,	country, city)
VALUES ('SOF', 'Sofia International', 'Bulgaria', 'Sofia'),
('CDG', 'Charles De Gaulle', 'France', 'Paris'),
('ORY', 'Orly', 'France', 'Paris'),
('LBG', 'Le Bourget', 'France', 'Paris'),
('JFK', 'John F Kennedy International', 'United States', 'New York'),
('ORD', 'Chicago O''Hare International', 'United States', 'Chicago'),
('FCO', 'Leonardo da Vinci International', 'Italy', 'Rome'),
('LHR', 'London Heathrow', 'United Kingdom', 'London');

INSERT INTO AIRPLANE(code, type, seats,	year)
VALUES ('319', 'Airbus A319', 150, 1993),
('320', 'Airbus A320', 280, 1984),
('321', 'Airbus A321', 150, 1989),
('100', 'Fokker 100', 80, 1991),
('738', 'Boeing 737-800', 90, 1997),
('735', 'Boeing 737-800', 90, 1995);

INSERT INTO FLIGHT(fnumber,	airline_operator, dep_airport,
				   arr_airport, flight_time, flight_duration,
				   airplane)
VALUES ('FB1363', 'AZ', 'SOF', 'ORY', '12:45', 100, '738'),
('FB1364', 'AZ', 'CDG', 'SOF', '10:00', 120, '321'),
('SU2060', 'AZ', 'LBG', 'SOF', '11:10', 110, '738'),
('SU2061', 'TK', 'SOF', 'JFK', '13:00', 110, '320'),
('FB363', 'FB', 'SOF', 'ORD', '15:10', 110, '738'),
('FB364', 'FB', 'LHR', 'SOF', '21:05', 120, '738');

INSERT INTO CUSTOMER(id, FNAME, LNAME, email)
VALUES (1, 'Petar', 'Milenov', 'petter@mail.com'),
(2, 'Dimitar', 'Petrov', 'petrov@mail.com'),
(3, 'Ivan', 'Ivanov', 'ivanov@mail.com'),
(4, 'Petar', 'Slavov', 'slavov@mail.com'),
(5, 'Bogdan', 'Bobov', 'bobov@mail.com');

INSERT INTO AGENCY(name, country, city,	phone)
VALUES ('Travel One', 'Bulgaria', 'Sofia', '0783482233'),
('Travel Two', 'Bulgaria', 'Plovdiv', '02882234'),
('Travel Tour', 'Bulgaria', 'Sofia', NULL),
('Aerotravel', 'Bulgaria', 'Varna', '02884233');

INSERT INTO BOOKING(code, agency, airline_code,
					flight_number, customer_id, booking_date,
					flight_date, price,	status)
VALUES ('YN298P', 'Travel One', 'FB', 'FB1363', 1, '2013-11-18', '2013-12-25', 300, 0),
('YA298P', 'Travel Two', 'FB', 'FB1364', 2, '2013-12-18', '2013-12-25', 300, 1),
('YB298P', 'Travel Tour', 'FB', 'SU2060', 3, '2014-01-18', '2014-02-25', 400, 0),
('YC298P', 'Travel One', 'FB', 'SU2061', 4, '2014-11-11', '2014-11-25', 350, 0),
('YD298P', 'Travel Tour', 'FB', 'FB363', 1, '2013-11-03', '2013-12-20', 250, 1),
('YE298P', 'Aerotravel', 'FB', 'FB364', 2, '2013-11-07', '2013-12-21', 150, 0);
