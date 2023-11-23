
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
prompt Requirement 1
prompt ENGLISH STATEMENTS (also have comments in the script)

-- ONE task MAY be allocated to MANY workers.
-- ONE worker MAY have MANY task allocations.
-- MANY workers may be allocated to ONE task.
-- MANY tasks may be allocated to ONE worker.

prompt ONE task MAY be allocated to MANY workers.
prompt ONE worker MAY have MANY task allocations.
prompt MANY workers may be allocated to ONE task.
prompt MANY tasks may be allocated to ONE worker.

prompt --------------------------------------------------------------
prompt Requirement 2
prompt DROP ALL TABLES

drop table taskman;
drop table expman;
drop table expertise;
drop table manager;
drop table timelog;
drop table allocation;
drop table task;
drop table worker;

prompt --------------------------------------------------------------
prompt Requirement 3
prompt CREATE ALL TABLES 

create table worker(
Wrkid number(4) not null,
Wrkname varchar(30),
Wrkgender varchar(1),
yearsservice  number(4),
status varchar(30),
CONSTRAINT PK_worker PRIMARY KEY (Wrkid),
CONSTRAINT CK_WORKER_wrkgender CHECK (Wrkgender='M' OR Wrkgender='F')
);

create table task(
tskid number(4) not null,
tskdescription varchar(30),
categorytype varchar(1),
PRIMARY KEY (tskid)
);

create table allocation(
Wrkid number(4) not null,
tskid number(4) not null,
HourlyRate number(5,2),
CONSTRAINT PK_allocation PRIMARY KEY (tskid,Wrkid),
FOREIGN KEY (Wrkid) REFERENCES worker,
FOREIGN KEY (tskid) REFERENCES task,
CONSTRAINT CK_ALLOCATION_RATE  CHECK (HourlyRate>=0.00 AND HourlyRate<=299.99)
);

prompt --------------------------------------------------------------
prompt Requirement 4
prompt insert worker, task and allocation data

--insert data into worker table
insert into worker (Wrkid,Wrkname,Wrkgender,status,yearsservice) values (1,'Clyde','M','International',2);
insert into worker (Wrkid,Wrkname,Wrkgender,status,yearsservice) values (2,'Sally','F','Local',9);
insert into worker (Wrkid,Wrkname,Wrkgender,status,yearsservice) values (3,'Imogen','F','International',4);
insert into worker (Wrkid,Wrkname,Wrkgender,status,yearsservice) values (4,'James','M','Local',3);
insert into worker (Wrkid,Wrkname,Wrkgender,status,yearsservice) values (5,'Tara','F','International',6);
insert into worker (Wrkid,Wrkname,Wrkgender,status,yearsservice) values (6,'Mike','M','Local',8);
insert into worker (Wrkid,Wrkname,Wrkgender,status,yearsservice) values (7,'Kerri','F','Local',5);

--insert data into task table
insert into task (tskid,tskdescription,categorytype) values (151,'Web Design','A');
insert into task (tskid,tskdescription,categorytype) values (155,'Python Coding','A');
insert into task (tskid,tskdescription,categorytype) values (163,'Sales and Marketing','B');
insert into task (tskid,tskdescription,categorytype) values (165,'Testing','C');
insert into task (tskid,tskdescription,categorytype) values (171,'Documentation','C');

--insert data into allocation table
insert into allocation (Wrkid,tskid,HourlyRate) values (1,163,45.50);
insert into allocation (Wrkid,tskid,HourlyRate) values (2,155,30);
insert into allocation (Wrkid,tskid,HourlyRate) values (5,165,30);
insert into allocation (Wrkid,tskid,HourlyRate) values (3,163,65);
insert into allocation (Wrkid,tskid,HourlyRate) values (5,155,27);
insert into allocation (Wrkid,tskid,HourlyRate) values (5,151,25);
insert into allocation (Wrkid,tskid,HourlyRate) values (2,165,25);
insert into allocation (Wrkid,tskid,HourlyRate) values (1,151,50.75);
insert into allocation (Wrkid,tskid,HourlyRate) values (7,163,40);

prompt --------------------------------------------------------------
prompt Requirement 5
prompt Write a single SQL query statement that lists the work id, worker name, task id, task name and, hourly rate for each row in the allocation table.

select 
W.wrkid as "Worker Id",
w.wrkname as "Worker Name",
t.tskid as "Task Id",
t.tskdescription as "Task Name",
a.HourlyRate as "Hourly Rate"

from allocation a
inner join worker w
on w.wrkid=a.wrkid
inner join task t
on t.tskid=a.tskid;

prompt --------------------------------------------------------------
prompt Requirement 6
prompt Testing Primary and foreign key constraints

insert into allocation (Wrkid,tskid,HourlyRate) values (1,163,100);
insert into allocation (Wrkid,tskid,HourlyRate) values (5,155,99);


prompt --------------------------------------------------------------
prompt Requirement 7
prompt Testing Check constraints

insert into allocation (Wrkid,tskid,HourlyRate) values (1,155,500);
insert into allocation (Wrkid,tskid,HourlyRate) values (6,171,399);

prompt --------------------------------------------------------------
prompt Requirement 8
prompt Querys 8.1

Select 
count(*) as "Total Allocation"
from allocation;

prompt Query 8.2 

Select 
categorytype as "Task Category",
count(*) as "Total Allocation"
from task 
group by categorytype;

prompt Query 8.3
 
Select Wrkgender as "Gender",
count(*) as "Total Allocation"
from worker
group by Wrkgender;

prompt Query 8.4  

Select status as "Status Type",
Wrkgender as "Gender",
count(*) as "Count"
from worker
group by status,Wrkgender
order by status, Wrkgender asc;

Prompt --------------------------------------------------------------
prompt Requirement 9
prompt Transfered to the requirement 2

Prompt --------------------------------------------------------------
prompt Requirement 10
prompt CREATE TABLES - Timelog

create table timelog(
Wrkid number(4)not null,
tskid number(4)not null,
Weekno number(2)not null,
Hrsworked number(4,1),
CONSTRAINT PK_timelog PRIMARY KEY (Wrkid,tskid,Weekno),
CONSTRAINT FK_allocation FOREIGN KEY (tskid,Wrkid) REFERENCES allocation
);

prompt --------------------------------------------------------------
prompt Requirement 11
prompt insert Timelog data

insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (1,163,39,10);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (1,163,40,8);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (1,163,42,6);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (1,151,41,5);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (1,151,42,5.5);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (2,155,39,10);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (2,165,39,15);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (2,155,42,10);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (2,165,40,20);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (2,155,41,10);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (5,155,39,8);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (5,155,40,6);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (5,155,41,5);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (5,151,42,11.5);

prompt --------------------------------------------------------------
prompt Requirement 12
prompt Testing Primary and foreign key constraints 

insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (1,171,43,5); 
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (10,163,40,2);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (3,155,40,10); 
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (5,188,39,10);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (1,163,39,2);
insert into timelog (Wrkid,tskid,Weekno,Hrsworked) values (5,151,42,6);

prompt --------------------------------------------------------------
prompt Requirement 13
prompt Listing Timelog data

select 
W.wrkid as "Worker Id",
w.wrkname as "Worker Name",
t.tskid as "Task Id",
t.tskdescription as "Task Name",
ti.Weekno as "WeekNo",
ti.Hrsworked as "HrsWorked"

from timelog ti
inner join worker w
on w.wrkid=ti.wrkid
inner join task t
on t.tskid=ti.tskid;

prompt --------------------------------------------------------------
prompt Requirement 14 
prompt Query 14.1 

Select 
ti.wrkid as"Worker Id",
w.Wrkname as"Worker Name",
ti.Weekno as "Week Number",
ti.tskid as "Task Number",
ti.Hrsworked as "Hours Worked",
ti.Hrsworked*a.HourlyRate as "Total Pay"

from timelog ti
inner join worker w
on w.Wrkid=ti.Wrkid 
inner join allocation a
on ti.tskid=a.tskid and a.Wrkid=ti.Wrkid
order by ti.Wrkid,ti.Weekno,ti.tskid asc;

prompt Query 14.2

Select
w.wrkid as "Worker Id",
w.Wrkname as"Worker Name",
ti.Weekno as "Week Number",
ti.Hrsworked*a.HourlyRate as "Total Pay"

from timelog ti
inner join worker w
on w.wrkid=ti.wrkid 
inner join allocation a
on ti.tskid=a.tskid and a.Wrkid=ti.Wrkid
order by ti.Wrkid,ti.Weekno asc;

prompt Query 14.3 

Select
ti.wrkid as"Worker Id",
w.Wrkname as"Worker Name",
sum(ti.Hrsworked*a.HourlyRate) as "Total Pay"

from timelog ti
inner join worker w
on w.wrkid=ti.wrkid 
inner join allocation a
on ti.tskid=a.tskid and a.Wrkid=ti.Wrkid
group by w.Wrkname,ti.wrkid
order by ti.wrkid asc;

prompt Query 14.4 

Select 
ti.Weekno as "Week Number",
SUM(ti.Hrsworked*a.HourlyRate) as "Total Pay"

from timelog ti
inner join allocation a
on ti.tskid=a.tskid and a.Wrkid=ti.Wrkid
group by ti.Weekno
order by ti.Weekno asc;

prompt Query 14.5 

Select
ti.tskid as "Task Id",
t.tskdescription as "Task Description", 
ti.HrsWorked as "Total Hours",
ti.Hrsworked*a.HourlyRate as "Total Pay"

from timelog ti
inner join allocation a
on ti.tskid=a.tskid and a.Wrkid=ti.Wrkid
inner join task t
on ti.tskid=t.tskid 
where ti.HrsWorked>0
group by ti.tskid,t.tskdescription,ti.Hrsworked,a.Hourlyrate
order by ti.tskid asc;

prompt Query 14.6 

Select 
w.Wrkid as "Worker Id",
w.Wrkname as "Worker name", 
SUM(ti.HrsWorked) as "Total Hours"

from timelog ti 
right outer join worker w
on ti.Wrkid=w.Wrkid
group by w.Wrkid,w.Wrkname
order by w.Wrkid asc;

prompt --------------------------------------------------------------
prompt Requirement 15
prompt Transfered to the requirement 2

prompt --------------------------------------------------------------
prompt Requirement 16
prompt CREATE TABLES - Manager and other required tables 

create table manager(
mgrid number(3),
Mgrname varchar(30),
mgrgender varchar(1),
CONSTRAINT PK_manager PRIMARY KEY (mgrid),
CONSTRAINT CHK_MANAGER_GENDER CHECK (mgrgender='F' OR mgrgender='M'),
CONSTRAINT CHK_MANAGER_ID CHECK (mgrid>=70 AND mgrid<=150),
CONSTRAINT UC_MANAGER_NAME UNIQUE (Mgrname)
);

create table taskman(
mgrid number(3),
tskid number(4),
CONSTRAINT PK_taskman PRIMARY KEY (mgrid,tskid),
FOREIGN KEY (tskid) REFERENCES task,
FOREIGN KEY (mgrid) REFERENCES manager
);

create table expertise(
Expertise varchar(30),
primary key(Expertise)
);

create table expman(
mgrid number(3),
Expertise varchar(30),
PRIMARY KEY (mgrid,Expertise),
CONSTRAINT CHK_expman_mgrid check (mgrid>=70 AND mgrid<=150),
FOREIGN KEY (Expertise) REFERENCES expertise
);

prompt --------------------------------------------------------------
prompt Requirement 17
prompt insert Manager and other required table data

--insert data to manager table
insert into manager(mgrid,Mgrname,mgrgender) values (71,'Sue','F');
insert into manager(mgrid,Mgrname,mgrgender) values (72,'Fred','M');
insert into manager(mgrid,Mgrname,mgrgender) values (73,'Mike','M');
insert into manager(mgrid,Mgrname,mgrgender) values (74,'Lilly','F');
insert into manager(mgrid,Mgrname,mgrgender) values (75,'Tara','F');
insert into manager(mgrid,Mgrname,mgrgender) values (76,'Albert','M');

--insert data to taskman table (junction table)
insert into taskman(mgrid,tskid) values (71,163);
insert into taskman(mgrid,tskid) values (72,151);
insert into taskman(mgrid,tskid) values (71,155);
insert into taskman(mgrid,tskid) values (73,163);
insert into taskman(mgrid,tskid) values (73,171);
insert into taskman(mgrid,tskid) values (74,163);
insert into taskman(mgrid,tskid) values (74,165);
insert into taskman(mgrid,tskid) values (74,171);
insert into taskman(mgrid,tskid) values (75,151);
insert into taskman(mgrid,tskid) values (75,155);
insert into taskman(mgrid,tskid) values (75,171);

--insert data to expertise table
insert into expertise(Expertise) values ('Analysis');
insert into expertise(Expertise) values ('Counselling');
insert into expertise(Expertise) values ('Negotiating');
insert into expertise(Expertise) values ('Motivation');
insert into expertise(Expertise) values ('Training');

--insert data to expman table (expertise table)
insert into expman(mgrid,Expertise) values (71,'Counselling');
insert into expman(mgrid,Expertise) values (71,'Negotiating');
insert into expman(mgrid,Expertise) values (72,'Analysis');
insert into expman(mgrid,Expertise) values (73,'Motivation');
insert into expman(mgrid,Expertise) values (73,'Analysis');
insert into expman(mgrid,Expertise) values (74,'Negotiating');
insert into expman(mgrid,Expertise) values (74,'Motivation');
insert into expman(mgrid,Expertise) values (75,'Training');
insert into expman(mgrid,Expertise) values (75,'Counselling');
insert into expman(mgrid,Expertise) values (75,'Motivation');
insert into expman(mgrid,Expertise) values (76,'Analysis');

prompt --------------------------------------------------------------
prompt Requirement 18
prompt Testing Check constraints
 
insert into manager (mgrid,Mgrname,mgrgender) values (50, 'Ben', 'M');
insert into manager (mgrid,Mgrname,mgrgender) values (81, 'Kurt', 'X');
insert into manager (mgrid,Mgrname,mgrgender) values (82, 'Fred', 'M');
insert into manager (mgrid,Mgrname,mgrgender) values (83, 'Tara', 'F');

prompt --------------------------------------------------------------
prompt Requirement 19
prompt Query 19.1

Select 
m.Mgrname as "Manager Name",
count(a.wrkid) as "Number of Worker"

from manager m
inner join taskman ta 
on ta.mgrid=m.mgrid
inner join allocation a 
on ta.tskid=a.tskid
group by m.Mgrname
order by m.Mgrname asc;

prompt Query 19.2 

Select
m.Mgrname as "Manager Name",
ex.Expertise as "Expertise",
a.tskid as "Task"

from manager m
inner join expman ex 
on ex.mgrid=m.mgrid 
inner join taskman ta 
on ta.mgrid=m.mgrid
inner join allocation a 
on ta.tskid=a.tskid
group by m.Mgrname, ex.Expertise,a.tskid
order by m.Mgrname, ex.Expertise asc;

prompt Query 19.3

Select 
Wrkid as "Worker Id", 
Wrkname as "Worker Name",
yearsservice as "Year Service"

from worker 
where yearsservice < (Select AVG (yearsservice) from worker)
order by Wrkid asc;

Prompt End of the project 







