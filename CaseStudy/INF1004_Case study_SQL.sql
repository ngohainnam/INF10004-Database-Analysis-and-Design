prompt START OF OUTPUT SECTION
-- STUDENT NAMES and IDs
prompt Student 1 ID:    103488515
prompt Student 1 Name:  Hai Nam Ngo

prompt Student 2 ID:    104057343
prompt Student 2 Name:  Viet Bach Le

prompt Student 3 ID:    104154163
prompt Student 3 Name:  Bianca Mathieu

--Hai Nam Ngo 103488515
--Viet Bach Le 104057343
--Bianca Mathieu 104154163

prompt --------------------------------------------------------------
prompt Requirement 4
prompt Drop all table 
--drop weak entities
drop table staffskill;
drop table actselect;
drop table actoffer;
drop table payment;
drop table booking;
drop table assistants;
drop table event;
drop table brochure;

--drop strong entities
drop table theskill;
drop table staff;
drop table activities;
drop table customer;
drop table adventure;

prompt Create all table
--create strong entities
create table adventure(
adcode varchar2(4) not null,
duration number(10) not null,
accomtype varchar2(10) not null,
price number(5) not null,
addesc varchar2 (100) not null,
constraint pk_adventure primary key (adcode)
);

create table customer(
custno number(4) not null,
cname varchar2(20) not null,
address varchar2(30) not null,
phone number(10) not null,
constraint pk_customer primary key (custno)
);

create table activities(
actcode varchar2(2) not null,
actdesc varchar2(20) not null,
constraint pk_activities primary key (actcode)
);

create table staff(
staffid number(3) not null,
staffname varchar2(20) not null,
constraint pk_staff primary key (staffid)
);

create table theskill(
skills varchar2(20) not null,
constraint pk_theskill primary key (skills)
);

--create weak entities
create table brochure(
adcode varchar2(4) not null,
custno number(4) not null,
reqdate varchar2(20) not null,
sentdate varchar2(20) not null,
constraint pk_brochure primary key (adcode,custno),
constraint fk_brochure_adventure foreign key (adcode) REFERENCES adventure(adcode),
constraint fk_brochure_customer foreign key (custno) REFERENCES customer(custno)
);

create table event(
adcode varchar2(4) not null,
startdate varchar2(20) not null,
staffid number(3) not null,
constraint pk_event primary key (adcode,startdate),
constraint fk_event_adventure foreign key (adcode) REFERENCES adventure(adcode),
constraint fk_event_staff foreign key (staffid) REFERENCES staff(staffid)
);

create table booking(
custno number(4) not null,
adcode varchar2(4) not null,
startdate varchar2(20) not null,
fee number(5) not null,
constraint pk_booking primary key (custno,adcode,startdate),
constraint fk_booking_customer foreign key (custno) REFERENCES customer(custno),
constraint fk_booking_event foreign key (adcode,startdate) REFERENCES event(adcode,startdate)
);

create table payment(
startdate varchar2(20) not null,
adcode varchar2(4) not null,
custno number(4) not null,
paydate varchar2(20) not null,
amountpaid number(5) not null,
constraint pk_payment primary key (custno,adcode,startdate,paydate),
constraint fk_payment_booking foreign key (custno,adcode,startdate) REFERENCES booking(custno,adcode,startdate)
);


create table actoffer(
adcode varchar2(4) not null,
startdate varchar2(20) not null,
actcode varchar2(2) not null,
constraint pk_actoffer primary key (adcode,startdate,actcode),
constraint fk_actoffer_event foreign key (adcode,startdate) REFERENCES event(adcode,startdate),
constraint fk_actoffer_activities foreign key (actcode) REFERENCES activities(actcode)
);

create table actselect(
adcode varchar2(4) not null,
startdate varchar2(20) not null,
actcode varchar2(2) not null,
custno number(4) not null,
constraint pk_actselect primary key (adcode,startdate,actcode,custno),
constraint fk_actselect_actoffer foreign key (adcode,startdate,actcode) REFERENCES actoffer(adcode,startdate,actcode),
constraint fk_actselect_booking foreign key (custno,adcode,startdate) REFERENCES booking(custno,adcode,startdate)
);

create table assistants(
staffid number(3) not null,
adcode varchar2(4) not null,
startdate varchar2(20) not null,
constraint pk_assistants primary key (adcode,startdate,staffid),
constraint fk_assistants_staff foreign key (staffid) REFERENCES staff(staffid),
constraint fk_assistants_event foreign key (adcode,startdate) REFERENCES event(adcode,startdate)
);

create table staffskill(
staffid number(3) not null,
skills varchar2(20) not null,
constraint pk_staffskill primary key (staffid,skills),
constraint fk_staffskill_staff foreign key (staffid) REFERENCES staff(staffid),
constraint fk_staffskill_theskill foreign key (skills) REFERENCES theskill(skills)
);

prompt --------------------------------------------------------------
prompt Requirement 5
prompt Insert data 
prompt adventure table
insert into adventure (adcode,duration,price,accomtype,addesc) values ('GR01',3,580,'Motel','Great Ocean Rd Motel Adventure');
insert into adventure (adcode,duration,price,accomtype,addesc) values ('GR04',7,680,'Camping','Great Ocean Rd Camping dventure');
insert into adventure (adcode,duration,price,accomtype,addesc) values ('YV02',2,195,'Hotel','Yarra Valley Winery Getaway');
insert into adventure (adcode,duration,price,accomtype,addesc) values ('GL02',5,695,'Hotel','Murray River Golf Getaway');

prompt customer table 
insert into customer (custno,cname,address,phone) values (1145,'Joel Black','12 Glenferrie Rd, Malvern',0981837492);
insert into customer (custno,cname,address,phone) values (1444,'Alan Rock','7 Green Ave, Hawthorn',0382649382);
insert into customer (custno,cname,address,phone) values (1805,'Ed Bailey','2 Red St, Richmond',0394659164);
insert into customer (custno,cname,address,phone) values (1274,'Jim Sykes','1 John St, Kew',0284957463);
insert into customer (custno,cname,address,phone) values (1333,'Sue Ryan','2 Bell St, Dingley',0293758475);
insert into customer (custno,cname,address,phone) values (1810,'Ted White','7 Oak Rd, Hawthorn',0284759385);
insert into customer (custno,cname,address,phone) values (1334,'Peter Ryan','2 Bell St, Dingley',0384759385);
insert into customer (custno,cname,address,phone) values (1299,'Jeff Brown','4 Hill Ave, Kew',0485968754);
insert into customer (custno,cname,address,phone) values (521,'Helen Mills','8 Dale St, Kew',0394758696);

prompt activities table 
insert into activities (actcode,actdesc) values ('S1','Shopping');
insert into activities (actcode,actdesc) values ('S2','Surfing');
insert into activities (actcode,actdesc) values ('G1','GolfLessons');
insert into activities (actcode,actdesc) values ('M1','Movies');
insert into activities (actcode,actdesc) values ('P1','Pottery');
insert into activities (actcode,actdesc) values ('A4','Art Tour');
insert into activities (actcode,actdesc) values ('R1','Rock Climbing');
insert into activities (actcode,actdesc) values ('T2','MAH Party');

prompt staff table 
insert into staff (staffid,staffname) values (101,'John Bull');
insert into staff (staffid,staffname) values (125,'Sue Brown');
insert into staff (staffid,staffname) values (174,'Eric Ng');
insert into staff (staffid,staffname) values (213,'Henry Blake');
insert into staff (staffid,staffname) values (333,'Nick Davis');
insert into staff (staffid,staffname) values (351,'Jane Scott');
insert into staff (staffid,staffname) values (394,'Sonia Chen');
insert into staff (staffid,staffname) values (400,'Trudy Lee');

prompt theskill table 
insert into theskill (skills) values ('Cooking');
insert into theskill (skills) values ('Bus Driver');
insert into theskill (skills) values ('First Aid');
insert into theskill (skills) values ('Horse Riding');
insert into theskill (skills) values ('Surfing');
insert into theskill (skills) values ('Golf');

prompt brochure table 
insert into brochure (reqdate,sentdate,custno,adcode) values ('2021/07/16','2021/07/18',1274,'YV02');
insert into brochure (reqdate,sentdate,custno,adcode) values ('2021/07/21','2021/07/21',1805,'GR01');
insert into brochure (reqdate,sentdate,custno,adcode) values ('2021/07/28','2021/08/01',1299,'GL02');
insert into brochure (reqdate,sentdate,custno,adcode) values ('2021/08/07','2021/08/07',1810,'GR04');

prompt event table 
insert into event (adcode,startdate,staffid) values ('YV02','2021/09/17',101);
insert into event (adcode,startdate,staffid) values ('GL02','2021/09/18',351);
insert into event (adcode,startdate,staffid) values ('GR01','2021/09/18',400);
insert into event (adcode,startdate,staffid) values ('GR01','2021/09/25',213);

prompt assistants table
insert into assistants (staffid,adcode,startdate) values (125,'YV02','2021/09/17');
insert into assistants (staffid,adcode,startdate) values (174,'YV02','2021/09/17');
insert into assistants (staffid,adcode,startdate) values (333,'GL02','2021/09/18');
insert into assistants (staffid,adcode,startdate) values (394,'GR01','2021/09/18');
insert into assistants (staffid,adcode,startdate) values (213,'GR01','2021/09/18');
insert into assistants (staffid,adcode,startdate) values (125,'GR01','2021/09/25');
insert into assistants (staffid,adcode,startdate) values (351,'GR01','2021/09/25');

prompt booking table
insert into booking (custno,adcode,startdate,fee) values (1145,'GR01','2021/09/25',580);
insert into booking (custno,adcode,startdate,fee) values (1444,'YV02','2021/09/17',195);
insert into booking (custno,adcode,startdate,fee) values (1274,'YV02','2021/09/17',195);
insert into booking (custno,adcode,startdate,fee) values (1333,'GR01','2021/09/18',580);
insert into booking (custno,adcode,startdate,fee) values (1334,'GR01','2021/09/18',580);
insert into booking (custno,adcode,startdate,fee) values (1299,'GL02','2021/09/18',695);
insert into booking (custno,adcode,startdate,fee) values (521,'GL02','2021/09/18',695);

prompt payment table
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (1145,'GR01','2021/09/25','2021/09/01',580);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (1444,'YV02','2021/09/17','2021/08/03',100);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (1444,'YV02','2021/09/17','2021/08/28',95);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (1274,'YV02','2021/09/17','2021/08/20',195);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (1333,'GR01','2021/09/18','2021/08/10',580);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (1299,'GL02','2021/09/18','2021/07/15',695);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (1334,'GR01','2021/09/18','2021/08/14',580);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (521,'GL02','2021/09/18','2021/06/15',250);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (521,'GL02','2021/09/18','2021/07/14',250);
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (521,'GL02','2021/09/18','2021/08/16',195);

prompt actoffer table
insert into actoffer (adcode,startdate,actcode) values ('YV02','2021/09/17','A4');
insert into actoffer (adcode,startdate,actcode) values ('YV02','2021/09/17','P1');
insert into actoffer (adcode,startdate,actcode) values ('YV02','2021/09/17','S1');
insert into actoffer (adcode,startdate,actcode) values ('GL02','2021/09/18','M1');
insert into actoffer (adcode,startdate,actcode) values ('GL02','2021/09/18','P1');
insert into actoffer (adcode,startdate,actcode) values ('GL02','2021/09/18','G1');
insert into actoffer (adcode,startdate,actcode) values ('GR01','2021/09/18','S1');
insert into actoffer (adcode,startdate,actcode) values ('GR01','2021/09/18','S2');
insert into actoffer (adcode,startdate,actcode) values ('GR01','2021/09/25','S1');
insert into actoffer (adcode,startdate,actcode) values ('GR01','2021/09/25','S2');
insert into actoffer (adcode,startdate,actcode) values ('GR01','2021/09/25','G1');

prompt actselect table 
insert into actselect (custno,adcode,startdate,actcode) values (1145,'GR01','2021/09/25','S2'); 
insert into actselect (custno,adcode,startdate,actcode) values (1444,'YV02','2021/09/17','P1');
insert into actselect (custno,adcode,startdate,actcode) values (1444,'YV02','2021/09/17','S1');
insert into actselect (custno,adcode,startdate,actcode) values (1274,'YV02','2021/09/17','A4');
insert into actselect (custno,adcode,startdate,actcode) values (1274,'YV02','2021/09/17','P1');
insert into actselect (custno,adcode,startdate,actcode) values (1333,'GR01','2021/09/18','S2');
insert into actselect (custno,adcode,startdate,actcode) values (1334,'GR01','2021/09/18','S2');
insert into actselect (custno,adcode,startdate,actcode) values (1299,'GL02','2021/09/18','G1');
insert into actselect (custno,adcode,startdate,actcode) values (521,'GL02','2021/09/18','G1');

prompt staffskill table 
insert into staffskill (staffid,skills) values (101,'Cooking');
insert into staffskill (staffid,skills) values (101,'Bus Driver');
insert into staffskill (staffid,skills) values (101,'First Aid');
insert into staffskill (staffid,skills) values (125,'Horse Riding');
insert into staffskill (staffid,skills) values (174,'Bus Driver');
insert into staffskill (staffid,skills) values (174,'First Aid');
insert into staffskill (staffid,skills) values (213,'First Aid');
insert into staffskill (staffid,skills) values (213,'Surfing');
insert into staffskill (staffid,skills) values (333,'Golf');
insert into staffskill (staffid,skills) values (333,'Bus Driver');
insert into staffskill (staffid,skills) values (351,'Golf');
insert into staffskill (staffid,skills) values (351,'Horse Riding');
insert into staffskill (staffid,skills) values (394,'First Aid');
insert into staffskill (staffid,skills) values (400,'Bus Driver');

prompt --------------------------------------------------------------
prompt Requirement 6
prompt Testing primary/foreign key constraint
--adventure table
insert into adventure (adcode,duration,price,accomtype,addesc) values ('GR01',4,580,'Hotel','bababa');

--customer table 
insert into customer (custno,cname,address,phone) values (1145,'Joel Adam','14 Glenferrie Rd, Malvern',0283947584);

--activities table 
insert into activities (actcode,actdesc) values ('S1','Shopping');

--staff table 
insert into staff (staffid,staffname) values (101,'John Bull');

--theskill table 
insert into theskill (skills) values ('Cooking');

--brochure table 
insert into brochure (reqdate,sentdate,custno,adcode) values ('2021/07/44','2021/08/18',1999,'YV02');

--event table 
insert into event (adcode,startdate,staffid) values ('YV44','2021/09/17',999);

--assistants table
insert into assistants (staffid,adcode,startdate) values (125,'YV44','2021/09/17');

--booking table
insert into booking (custno,adcode,startdate,fee) values (1145,'GR65','2021/09/25',580);

--payment table
insert into payment (custno,adcode,startdate,paydate,amountpaid) values (114,'GR01','2021/09/25','2021/09/01',580);

--actoffer table
insert into actoffer (adcode,startdate,actcode) values ('YV44','2021/09/17','A4');

--actselect table 
insert into actselect (custno,adcode,startdate,actcode) values (1195,'GR01','2021/09/25','S2'); 

--staffskill table 
insert into staffskill (staffid,skills) values (198,'Cooking');

prompt --------------------------------------------------------------
prompt Requirement 7
prompt Querys 7.1

Select 
custno as "Customer No",
cname as "Name",
address as "Address"

from customer
order by custno asc;

prompt Query 7.2

Select 
a.adcode as "Adventure code",
a.startdate as "Tour date",
s.staffname as "Staff name"
from staff s
inner join assistants a
on a.staffid=s.staffid

union

Select 
e.adcode as "Adventure code",
e.startdate as "Tour date",
s.staffname as "Staff name"
from staff s
inner join event e
on e.staffid=s.staffid
order by 1;

prompt Query 7.3

Select 
b.adcode as "Adventure code",
b.startdate as "Tour date",
b.custno as "Customer No",
c.cname as "Customer name"

from booking b
inner join customer c 
on b.custno=c.custno 
order by b.adcode,b.startdate,b.custno asc;
 
prompt Query 7.4

Select 
a.adcode as "Adventure code",
a.startdate as "Tour date",
a.actcode as "Activity code",
ac.actdesc as "Activity description" 

from actoffer a 
inner join activities ac
on a.actcode=ac.actcode 
order by a.adcode,a.startdate,a.actcode asc;

prompt Query 7.5 

Select 
ac.adcode as "Adventure code",
ac.startdate as "Tour date",
ac.custno as "Customer No",
c.cname as "Customer name",
ac.actcode as "Activity code",
a.actdesc as "Activity description"

from actselect ac 
inner join customer c 
on ac.custno=c.custno 
inner join activities a 
on a.actcode=ac.actcode 
order by ac.adcode,ac.startdate,ac.custno asc;

prompt --------------------------------------------------------------
prompt Requirement 8
prompt Querys 8.1

Select 
c.custno as "Customer no",
c.cname as "Customer name",
SUM(p.amountpaid) as "Total payment $"

from customer c 
left outer join payment p 
on c.custno=p.custno 
group by c.custno,c.cname
order by c.custno asc;

prompt Query 8.2 

Select 
a.adcode as "Tour code",
SUM(p.amountpaid) as "Total payment $"

from adventure a 
left outer join payment p 
on a.adcode=p.adcode 
group by a.adcode 
order by a.adcode asc;

prompt Query 8.3
 
Select 
a.actcode as "Activity code",
a.actdesc as "Activity description", 
count(ac.actcode) as "Selected time" 

from activities a 
left outer join actselect ac 
on ac.actcode=a.actcode
group by a.actcode,a.actdesc
order by count(ac.actcode) desc;

prompt Query 8.4  

Select 
a.adcode as "Adventure code",
a.addesc as "Adventure description",
a.price as "Most recent price $"

from adventure a 
order by 1;

prompt Query 8.5

Select 
br.custno as "Customer No",
c.cname as "Customer Name",
b.adcode as "Adventure code",
b.startdate as "Tour date" 

from customer c 
inner join booking b 
on b.custno=c.custno
inner join brochure br
on br.custno=c.custno
group by br.custno,c.cname,b.adcode,b.startdate;

Prompt End of the project 







