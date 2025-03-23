create database Bus_Reservation_System;
use Bus_Reservation_System;

---------------------------------------------------------------------------------------------------------

create table Bus(
Bus_id int primary key,
Bus_number varchar(100),
Bus_status varchar(100),
Bus_seats int
);

insert into Bus 
values(1, 'TN-47-AA-6705', 'Good', 30),
(2, 'TN-63-AW-4960', 'Excellent', 35),
(3, 'TN-39-AY-2777', 'Good', 30),
(4, 'TN-28-AT-2949', 'Good', 25),
(5, 'TN-47-AY-2166', 'Excellent', 40);

select * from Bus;

---------------------------------------------------------------------------------------------------------

create table Driver(
Driver_id int primary key,
Name varchar(100),
Phone_no bigint,
Bus_id int,
constraint FK_Driver foreign key(Bus_id) references Bus(Bus_id)
);

insert into Driver 
values(1, 'Kumar', 7564765746, 1),
(2, 'Pandiyan', 9934883493, 2),
(3, 'Kamal', 7974637643, 3),
(4, 'Parthiban', 6974737643, 4),
(5, 'Mohan', 8937463743, 5);

select * from Driver;

---------------------------------------------------------------------------------------------------------

create table Passenger(
Passenger_id int primary key,
First_name varchar(100),
Last_name varchar(100),
Gender varchar(20),
Age int,
Phone_no bigint,
Address varchar(500)
);

insert into Passenger
values(1, 'Ajai', 'kumar', 'Male', 40, 5551234567, '34, Bharathy Nagar, T. Nagar, Chennai, Tamil Nadu 600017'),
(2, 'John', 'joe', 'Male', 30, 5552345678, '23, Aruna Colony, Kodambakkam, Chennai, Tamil Nadu'),
(3, 'Gk', 'Johnson', 'Male', 25, 5553456789, '10, Satyamurthy Nagar, T. Nagar, Chennai, Tamil Nadu 600017'),
(4, 'Shobha', 'Sree', 'Female', 19, 9944893006, '401, Gandhi Rd, Chinna Kanchipuram, Ennaikaran, Arappanacheri, Tamil Nadu 631501'),
(5, 'Keerthi', 'saravanan', 'Female', 33, 8378667647, '9-2, Thandavarayan Mudali Street, Jam Bazaar, Vasudevan Puram, Triplicane, Chennai, Tamil Nadu 600005'),
(6, 'Ajith', 'Kumar', 'Male', 45, 5558901234, '11, Gandhi Road, Royapettah, Chennai, Tamil Nadu'),
(7, 'Nandhini', 'Rajesh', 'Female', 31, 5556785432, '15, Krishnapuram, Royapettah, Chennai, Tamil Nadu 600004'),
(8, 'Sathya', 'Arumugam', 'Female', 27, 5555674321, '411, Gopalapuram, Chennai, Tamil Nadu 600086'),
(9, 'Dhoni', 'MS', 'Female', 37, 5554563210, '87, Nungambakkam High Rd, Thousand Lights West, Thousand Lights, Chennai, Tamil Nadu 600006'),
(10, 'Anbu', 'Raj', 'Male', 24, 5553452109, '67, Bhuvaneshwari Nagar, Velachery, Chennai, Tamil Nadu');

select * from Passenger;

---------------------------------------------------------------------------------------------------------

create table Payment(
Payment_id int primary key,
Passenger_id int,
Amount int,
Payment_date date,
constraint FK_Payment foreign key(Passenger_id) references Passenger(Passenger_id)
);

insert into Payment
values
(1, 1, 1500, '2024-12-28'),
(2, 2, 1000, '2024-12-28'),
(3, 3, 2000, '2025-01-10'),
(4, 4, 1200, '2025-01-20'),
(5, 5, 2000, '2025-01-10'),
(6, 6, 2000, '2025-01-10'),
(7, 7, 1700, '2025-01-20'),
(8, 8, 3000, '2025-01-24'),
(9, 9, 1600, '2025-01-22'),
(10, 10, 1400, '2025-01-24');

select * from Payment;

---------------------------------------------------------------------------------------------------------

create table Reservation(
Reservation_id int primary key,
Passenger_id int,
Bus_id int,
Depart_time time,
Destination varchar(100),
Reservation_date date,
constraint FK_Reservation_1 foreign key(Passenger_id) references Passenger(Passenger_id),
constraint FK_Reservation_2 foreign key(Bus_id) references Bus(Bus_id)
);

insert into Reservation 
values(1, 1, 2, '20:30:00', 'Chennai to Madurai', '2024-12-28'),
(2, 2, 2, '20:30:00', 'Chennai to Thanjavur', '2024-12-28'),
(3, 3, 1, '18:00:00', 'Chennai to Koyamputhur', '2025-01-10'),
(4, 4, 3, '17:00:00', 'Viluppuram to Chennai', '2025-01-20'),
(5, 5, 1, '18:00:00', 'Chennai to Koyamputhur', '2025-01-10'),
(6, 6, 1, '18:00:00', 'Chennai to Kouamputhur', '2025-01-10'),
(7, 7, 3, '15:00:00', 'Thanjavur to Chennai', '2025-01-20'),
(8, 8, 5, '17:00:00', 'Kanniyakumari to Chennai', '2025-01-24'),
(9, 9, 4, '16:00:00', 'Puducherry to Chennai', '2025-01-22'),
(10, 10, 5, '21:00:00', 'Kumbakonam to Chennai', '2025-01-24');


select * from Reservation;

---------------------------------------------------------------------------------------------------------

-- View 

-- Reservation Details 
create view Reservation_Details as
select Reservation_id, passenger.First_name, passenger.Last_name, passenger.Phone_no, Gender, Bus_id, Depart_time, Reservation_date, Destination  
from Reservation
join Passenger on Reservation.Passenger_id = Passenger.Passenger_id; 

-- Bus and Driver Details 
create view Driver_Bus_Details as
select Driver_id, Name, Phone_no, Bus_number, Bus_status, Bus_seats from Driver 
join Bus on Driver.Bus_id = Bus.Bus_id;

-- Payment Details
create view Payment_Details as
select Payment_id, First_name, Last_name, Gender, Phone_no, Amount, Payment_date from Payment 
join Passenger on Payment.Passenger_id = Passenger.Passenger_id;

select * from Bus_Reservation_System.Reservation_Details;
select * from Bus_Reservation_System.Driver_Bus_Details;
select * from Bus_Reservation_System.Payment_Details;

---------------------------------------------------------------------------------------------------------

-- Stored Procedure

-- Reservation Details
Delimiter //
create procedure Reservation_Details()
begin
	select Reservation_id, passenger.First_name, passenger.Last_name, passenger.Phone_no, Gender, Bus_id, Depart_time, Reservation_date, Destination  
	from Reservation
	join Passenger on Reservation.Passenger_id = Passenger.Passenger_id;
end //
Delimiter ;

Delimiter //
create procedure Particular_Reservation_Details(in id int)
begin
	select Reservation_id, passenger.First_name, passenger.Last_name, passenger.Phone_no, Gender, Bus_id, Depart_time, Reservation_date, Destination  
	from Reservation
	join Passenger on Reservation.Passenger_id = Passenger.Passenger_id 
    where Reservation_id = id;
end //
Delimiter ;


-- Bus and Driver Details 
Delimiter //
create procedure Driver_Bus_Details()
begin 
	select Driver_id, Name, Phone_no, Bus_number, Bus_status, Bus_seats from Driver 
	join Bus on Driver.Bus_id = Bus.Bus_id;
end //
Delimiter ;

Delimiter //
create procedure Particular_Driver_Bus_Details(in id int)
begin 
	select Driver_id, Name, Phone_no, Bus_number, Bus_status, Bus_seats from Driver 
	join Bus on Driver.Bus_id = Bus.Bus_id 
    where Driver_id = id;
end //
Delimiter ;


-- Payment Details
Delimiter //
create procedure Payment_Details()
begin 
	select Payment_id, First_name, Last_name, Gender, Phone_no, Amount, Payment_date from Payment 
	join Passenger on Payment.Passenger_id = Passenger.Passenger_id;
end //
Delimiter ;

Delimiter //
create procedure Particular_Payment_Details(in id int)
begin 
	select Payment_id, First_name, Last_name, Gender, Phone_no, Amount, Payment_date from Payment 
	join Passenger on Payment.Passenger_id = Passenger.Passenger_id 
    where Payment_id = id;
end //
Delimiter ;


call Bus_Reservation_System.Reservation_Details();
call Bus_Reservation_System.Particular_Reservation_Details(1);

call Bus_Reservation_System.Driver_Bus_Details();
call Bus_Reservation_System.Particular_Driver_Bus_Details(1);

call Bus_Reservation_System.Payment_Details();
call Bus_Reservation_System.Particular_Payment_Details(1);

---------------------------------------------------------------------------------------------------------