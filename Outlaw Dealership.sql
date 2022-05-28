	-- Outlaw Dealership
-- Customer Table
create table Customer (
	Customer_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	address VARCHAR(150),
	billing_info VARCHAR(150)
);

-- Car Table
create table Car (
	VIN_number SERIAL primary key,
	cost_of_car INTEGER,
	make VARCHAR(100),
	model VARCHAR(100),
	year_ VARCHAR(100)
);

-- Salesperson Table
create table Salesperson (
	Salesperson_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(150)
);

-- Mechanic Table
create table Mechanic (
	Mechanic_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(150)
);

-- Invoice Table
create table Invoice (
	Invoice_id SERIAL primary key,
	Invoice_amount NUMERIC(10,2),
	Invoice_date DATE default CURRENT_DATE,
	Customer_id INTEGER,
	Salesperson_id INTEGER,
	VIN_number INTEGER,
	foreign key (customer_id) references customer(customer_id),
	foreign key (salesperson_id) references salesperson(salesperson_id),
	foreign key (VIN_number) references car(VIN_number)
);

-- Car Parts Table
create table CarParts(
	Part_number SERIAL primary key,
	part_name VARCHAR(100),
	part_amount NUMERIC(10,2),
	VIN_number INTEGER,
	make VARCHAR(100),
	model VARCHAR(100),
	year_ VARCHAR(100),
	customer_id INTEGER,
	mechanic_id INTEGER,
	foreign key(customer_id) references customer(customer_id),
	foreign key(mechanic_id) references mechanic(mechanic_id)
);

-- Service Ticket Table
create table ServiceTicket(
	ServiceTicket_id SERIAL primary key,
	ticket_id INTEGER,
	make VARCHAR(100),
	model VARCHAR(100),
	year_ VARCHAR(100),
	service_type VARCHAR(150),
	service_date DATE default CURRENT_DATE,
	service_cost NUMERIC(10,2),
	mechanic_id INTEGER,
	Part_number INTEGER,
	foreign key(mechanic_id) references mechanic(mechanic_id),
	foreign key (part_number) references CarParts(part_number)
);

-- Service Record
create table ServiceRecord (
	VIN_number SERIAL primary key,
	ServiceTicket_id INTEGER,
	foreign key (Serviceticket_id) references Serviceticket(Serviceticket_id)
);

-- Customer Information
insert into Customer(Customer_id, first_name, last_name, address, billing_info)
values (1, 'Oriah', 'Saint', '555 The Matrix Lane', '1000-7890-1234-5678 01/31');

insert into Customer(Customer_id, first_name, last_name, address, billing_info)
values(2, 'Joelle', 'Adams', '1200 Block Drive', '0987-6543-1234-0192 02/31');

insert into Customer(Customer_id, first_name, last_name, address, billing_info)
values(3, 'Amber', 'Saint', '13202 Briar Forest Dr', '1092-8273-4756-0987 03/31');

insert into Customer(Customer_id, first_name, last_name, address, billing_info)
values(4, 'Aisha', 'Alexander', '1800 Atlanta Ave', '0987=0987-1234-4321 06/31');

-- Car Information
insert into Car (VIN_number, cost_of_car, make, model, year_)
values (0, 54000.00, 'Tesla', 'Spaceship', '3030');

insert into Car (VIN_number, cost_of_car, make, model, year_)
values (1, 46000.00, 'Honda', 'Forward', '3030');

insert into Car (VIN_number, cost_of_car, make, model, year_)
values(2, 24000.00, 'Horse', 'Power', '2025');

insert into Car (VIN_number, cost_of_car, make, model, year_)
values(3, 12000.00, 'Cheeta', 'Vipe', '2022');

-- Salesperson Information
insert into Salesperson (Salesperson_id, first_name, last_name, email)
values (555, 'Schadre', 'Dent', 'SchadreDent@OutlawDealership.com');

insert into Salesperson (Salesperson_id, first_name, last_name, email)
values (333, 'Christopher', 'Jordan', 'ChrisJord@OutlawDealership.com');

-- Mechanic Information
insert into Mechanic (Mechanic_id, first_name, last_name, email)
values (666, 'Henry', 'Taylor', 'HenryTaylor@OutlawDealership.com');

insert into Mechanic (Mechanic_id, first_name, last_name, email)
values (777, 'Mark', 'Cuba', 'MarkCuba@OutlawDealership.com');

-- Invoice Information
insert into Invoice (Invoice_id, Invoice_amount, Customer_id, Salesperson_id, VIN_number)
values (1, 60000.00, 1, 555, 0);

insert into Invoice (Invoice_id, Invoice_amount, Customer_id, Salesperson_id, VIN_number)
values (2, 50000.00, 2, 555, 1);

insert into Invoice (Invoice_id, Invoice_amount, Customer_id, Salesperson_id, VIN_number)
values (3, 15000.00, 3, 333, 3);

-- Car Part Information
insert into CarParts (Part_number, part_name, part_amount, VIN_number, make, model, year_, customer_id, mechanic_id)
values (9, 'Brakes', 500.00, 3, 'Cheeta', 'Vipe', '2022', 3, 666);

insert into CarParts (Part_number, part_name, part_amount, VIN_number, make, model, year_, customer_id, mechanic_id)
values (8, 'Horse Engine', 5000.00, 999, 'Horse', 'Power', '2023', 4, 777);

-- Service Tickets
insert into ServiceTicket (ServiceTicket_id, ticket_id, make, model, year_, service_type, service_cost, mechanic_id, part_number)
values (22, 2, 'Cheeta', 'Vipe', '2022', 'Replacement breaks', 500.00, 666, 9);

insert into ServiceTicket (ServiceTicket_id, ticket_id, make, model, year_, service_type, service_cost, mechanic_id, part_number)
values(33, 3, 'Horse', 'Power', '2023', 'Replacement Engine', 5000.00, 777, 8);

-- Service Record
insert into ServiceRecord (VIN_number, ServiceTicket_id)
values (3, 22);

insert into ServiceRecord (VIN_number, ServiceTicket_id)
values(999, 33);

-- Adding a mechanic function
create or replace function add_Mechanic(_Mechanic_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _email VARCHAR)
returns void
as $MAIN$
begin 
	insert into Mechanic (Mechanic_id, first_name, last_name, email)
	values (_Mechanic_id, _first_name, _last_name, _email);
end;
$MAIN$
language plpgsql;


select add_Mechanic(888, 'John', 'Henry', 'JohnHenry@OutlawDealership.com');

select * from Mechanic where Mechanic_id = 888;

select * from Car
select * from CarParts
select * from customer
select * from invoice
select * from mechanic
select * from salesperson
select * from servicerecord
select * from serviceticket