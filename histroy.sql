--- 11-07-2023 20:33:23
--- SQLite
drop table demo;

--- 11-07-2023 20:33:40
--- SQLite
create table employee (
  fname varchar(255),
  minit char(1),
  lname varchar(255),
  ssn varchar(9),
  bdate date,
  address varchar(255),
  sex char(1),
  salary int,
  superssn varchar(9),
  dno int,
  constraint pk_employee primary key (ssn),
  constraint fk_employee_superssn foreign key (superssn) references employee (ssn),
  constraint fk_employee_dno foreign key (dno) references department (dnumber)
);

create table department (
  dname varchar(255),
  dnumber int,
  mgrssn varchar(9),
  mgrstartdate date,
  constraint pk_department primary key (dnumber),
  constraint fk_department_mgrssn foreign key (mgrssn) references employee (ssn)
);

create table dept_locations (
  dnumber int,
  dlocation varchar(255),
  constraint pk_dept_locations primary key (dnumber, dlocation),
  constraint fk_dept_locations_dnumber foreign key (dnumber) references department (dnumber)
);

create table project (
  pname varchar(255),
  pnumber int,
  plocation varchar(255),
  dnum int,
  constraint pk_project primary key (pnumber),
  constraint fk_project_dnum foreign key (dnum) references department (dnumber)
);

create table works_on (
  essn varchar(9),
  pno int,
  hours int,
  constraint pk_works_on primary key (essn, pno),
  constraint fk_works_on_essn foreign key (essn) references employee (ssn),
  constraint fk_works_on_pno foreign key (pno) references project (pnumber)
);

create table dependent (
  essn varchar(9),
  dependent_name varchar(255),
  sex char(1),
  bdate date,
  relationship varchar(255),
  constraint pk_dependent primary key (essn, dependent_name),
  constraint fk_dependent_essn foreign key (essn) references employee (ssn)
);

--- 11-07-2023 20:35:16
--- SQLite
alter table employee add piture blob;

--- 11-07-2023 20:37:17
--- SQLite
insert into department
values ('marketing',6,123456789,2019-7-13);

--- 11-07-2023 20:38:13
--- SQLite
delete from department
where dnumber = 6;

--- 11-07-2023 20:38:53
--- SQLite
select `sql` from `sqlite_master` where name LIKE 'department' and type LIKE 'table';

--- 11-07-2023 20:40:50
--- SQLite
update employee 
set salary = salary+100
where dno = 5;

--- 11-07-2023 20:45:33
--- SQLite
/***** ERROR ******
no such column: works_on.ssn
 ----- 
select employee.FNAME, employee.LNAME
from EMPLOYEE 
inner join works_on on employee.ssn = works_on.ssn
inner join PROJECT on works_on.pno = project.pnumber
inner join DEPARTMENT on project.dnum = department.dnumber
where department.dname = 'Research' and works_on.hours > 10;
*****/

--- 11-07-2023 20:45:45
--- SQLite
select employee.FNAME, employee.LNAME
from EMPLOYEE 
inner join works_on on employee.ssn = works_on.essn
inner join PROJECT on works_on.pno = project.pnumber
inner join DEPARTMENT on project.dnum = department.dnumber
where department.dname = 'Research' and works_on.hours > 10;

--- 11-07-2023 20:50:32
--- SQLite
select employee.FNAME, employee.LNAME
from EMPLOYEE 
inner join works_on on employee.ssn = works_on.essn
inner join PROJECT on works_on.pno = project.pnumber
inner join DEPARTMENT on project.dnum = department.dnumber
where department.dname = 'Research' and works_on.hours > 10 and project.pname = 'product ABC';

--- 11-07-2023 20:57:05
--- SQLite
select pname , sum(works_on.hours) as total_hours
from works_on 
inner join project on works_on.pno = project.pnumber
group by project.pname
having sum(works_on.hours)>50;

--- 11-07-2023 21:01:43
--- SQLite
select sum(employee.salary) as total_salary
from employee
inner join departmenton employee.dno = 'Research'
where employee.sex = 'F';

--- 11-07-2023 21:08:16
--- SQLite
/***** ERROR ******
no such column: dependent.dname
 ----- 
select employee.fname , employee.lname , dependent.dname
from employee
left join dependenton employee.ssn = department.ssn and relationship = 'spouse';
*****/

--- 11-07-2023 21:08:43
--- SQLite
/***** ERROR ******
no such column: dependent.dname
 ----- 
select employee.fname , employee.lname , dependent.dname
from employee
left join dependenton employee.ssn = department.ssn 
where dependent.relationship = 'spouse';
*****/

--- 11-07-2023 21:09:23
--- SQLite
/***** ERROR ******
no such column: department.ssn
 ----- 
select employee.fname , employee.lname , dependent.dependent_name
from employee
left join dependenton employee.ssn = department.ssn 
where dependent.relationship = 'spouse';
*****/

--- 11-07-2023 21:09:47
--- SQLite
select employee.fname , employee.lname , dependent.dependent_name
from employee
left join dependenton employee.ssn = dependent.essn
where dependent.relationship = 'spouse';

--- 11-07-2023 21:14:51
--- SQLite
DROP TABLE employee;
DROP TABLE department;
DROP TABLE dept_locations;
DROP TABLE project;
DROP TABLE works_on;
DROP TABLE dependent;

--- 11-07-2023 21:15:01
--- SQLite
/***** ERROR ******
no such table: employee
 ----- 
DROP TABLE employee;
DROP TABLE department;
DROP TABLE dept_locations;
DROP TABLE project;
DROP TABLE works_on;
DROP TABLE dependent;
*****/

