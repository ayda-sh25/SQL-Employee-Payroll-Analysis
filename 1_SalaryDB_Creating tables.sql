-- salaryDB
--1 creating database :
create database salaryDB;
go
use salaryDB;
go

--2 creating tables :
---1 Department:
create table Department(
DepartmentID int identity primary key,
Departmentname varchar (50) not null unique);

---2 Jobtitle :
create table Jobtitle(
JobtitleID int identity primary key,
Jobname varchar(50) not null unique);

---3 Employee :
create table Employee(
employeeID int identity primary key,
Firstname varchar(50) not null,
Lastname varchar(50) not null,
DepartmentID int not null,
JobtitleID int not null,
HireDate date not null,
Isactive bit not null default 1,
constraint fk_employee_department
foreign key (Departmentid)
references Department(DepartmentID),

constraint fk_employee_jobtitle
foreign key (JobtitleID)
references Jobtitle (Jobtitleid));

---4 Contract :
create table Contract(
contractID int not null identity primary key,
employeeID int not null,
ContractStartDate date not null,
ContractEndDate date,
BaseSalary decimal(20,0) not null,
FixedAllowance decimal(20,0) default 0,
AdditionalAllowance decimal (20,0) default 0,
GrossSalary decimal (20,0),
constraint FK_contract_employee
foreign key (employeeID)
references employee(employeeID));

---5 Timesheet
create table Timesheet(
TimesheetID int identity primary key,
employeeID int not null,
WorkMonth int not null,
WorkYear int not null,
WorkingDays int not null,
OvertimeMinutes int default 0,

constraint FK_Timesheet_Employee
foreign key (employeeID)
references employee(employeeID),

constraint CK_workingdays
check (workingdays between 0 and 31),

constraint CK_workmonth
check (workmonth between 1 and 12));

---6 Payroll
create table Payroll(
payrollID int identity primary key,
employeeID int not null,
PayMonth int not null,
PayYear int not null,
GrossSalary decimal (20,0) not null,
Insurance decimal (20,0) default 0,
OtherDeduction decimal (20,0) default 0,
NetSalary decimal (20,0) not null,

constraint FK_payroll_employee
foreign key (employeeID)
references employee(employeeID),

constraint CK_paymonth
check (paymonth between 1 and 12));
