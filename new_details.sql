create table Ambulance_driver(vehicle_no varchar(20) primarykey, driver_name varchar(30), contact_no varchar(15), rating float);

insert into Ambulance_driver values 
('KA016738', 'Saurabh Agarwala', '9876543210', 0), 
('KA048321', 'Thejaswini DM', '1234567890', 5), 
('KA052974', 'Khatri', '9699842088', 3), 
('KA091347', 'Apoorva', '9696942568', 5),
('KA075171', '17shashank17', '8494626969', 5),
('KA016392', 'madhuparna', '4204206969', 5);

alter table Ambulance_loc add column base_fare int;
alter table Ambulance_loc add column charge_per_km float;
update Ambulance_loc set base_fare=500, charge_per_km=20;