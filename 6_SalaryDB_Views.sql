use salaryDB
go 
---1) view-employee details :
create view employeedetailview
as 
select
	e.employeeid,
	e.firstname,
	e.lastname,
	d.Departmentname,
	j.Jobname,
	e.hiredate,
	e.isactive
from employee e	

inner join Department d
	on e.DepartmentID = d.DepartmentID	

inner join Jobtitle j 
	on e.JobtitleID = j.JobtitleID;

go 
select *
from employeedetailview;

---2) view-employee salary :
create view employeesalaryview
as 
select
	e.employeeid,
	e.firstname,
	e.lastname,
	d.Departmentname,
	j.jobname,
	c.basesalary
from employee e

inner join department d
	on e.DepartmentID = d.DepartmentID

inner join Jobtitle j 
	on e.JobtitleID = j.JobtitleID

inner join Contract c 
	on e.employeeID = c.employeeID;
go

select *
from employeesalaryview

---3) view-Employee Annual salary :
create view employeeannualsalary
as 
select
	e.employeeid,
	e.firstname,
	e.lastname,
	d.departmentname,
	c.basesalary,
	c.basesalary * 12 as annualsalary
from employee e

inner join Department d
	on e.DepartmentID = d.DepartmentID

inner join Jobtitle j
	on e.JobtitleID = j.JobtitleID

inner join contract c
	on e.employeeID = c.employeeID;
go

select *
from employeeannualsalary

---4) view-employee average salary :
create view employeaveragesalaryview
as 
select 
	e.employeeid,
	e.firstname,
	e.lastname,
	d.departmentname,
	avg(p.netsalary) as averagenetsalary

from employee e
inner join Department d
	on e.DepartmentID = d.DepartmentID
inner join payroll p 
	on e.employeeID = p.employeeID

group by 
	e.employeeID,	
	e.firstname,
	e.lastname,
	d.departmentname;
go 

select *
from employeaveragesalaryview

---5) view-employee payroll summary :
create view employeepayrollsummary
as 
select
	e.employeeid,
	e.firstname,
	e.lastname,
	d.departmentname,
	sum(p.grosssalary) as totalgrosssalary,
	sum(p.insurance) as totalinsurance,
	sum(p.netsalary) as totalnetsalary
from employee e
inner join Department d
	on e.DepartmentID = d.DepartmentID
inner join Payroll p 
	on e.employeeID	= p.employeeID
group by 
	e.employeeID,
	e.Firstname,
	e.Lastname,
	d.Departmentname;
go

select *
from employeepayrollsummary


---6) view-department monthly payroll :
create view departmentmonthlypayroll
as
select
	d.departmentname,
	p.payyear,
	p.paymonth,
	sum(p.grosssalary) as totalgrosssalary,
	sum(p.insurance) as totalinsurance,
	sum(p.otherdeduction) as totalotherdeduction,
	sum(p.netsalary) as totalnetsalary

from payroll p

inner join employee e 
	on e.employeeid = p.employeeid
inner join department d
	on d.departmentid = e.departmentid

group by 
	d.Departmentname,
	p.PayYear,
	p.PayMonth;


select *
from departmentmonthlypayroll


---7) view-employee overtime cost view :
create view employeeovertimecost
as 
select
	e.employeeid,
	e.firstname,
	e.lastname,
	d.departmentname,
	sum(t.overtimeminutes)/60.0 as totalovertimehours,
	sum(
		((c.basesalary/31.0)/8.0)*(t.overtimeminutes/60.0))as totalovertimecost
from employee e

inner join Department d
	on e.DepartmentID = d.DepartmentID

inner join Timesheet t
	on e.employeeID = t.employeeID

inner join Contract c
	on e.employeeID = c.employeeID

group by
	e.employeeID,
	e.Firstname,
	e.Lastname,
	d.Departmentname;
go

select *
from employeeovertimecost


---8) view employee payroll performance :
create view employeepayrollperformance 
as 
with payrollsummary as
(
	select
		employeeid,
		avg(netsalary) as averagenetsalary
	from payroll
	group by employeeid),

timesheetsummary as(
	select
		t.employeeid,
		sum(overtimeminutes)/60.0 as totalovertimehours,
		sum(31-workingdays) as totalabsencedays,
		sum(
			((c.basesalary/31.0)/8.0)
			*(t.overtimeminutes/60.0))
			as totalovertimecost,
		count (*) *31 as totalpossibledays

	from Timesheet t

	inner join Contract c
		on c.employeeID = t.employeeid

	group by t.employeeid)


select 
	e.employeeid,
	e.firstname,
	e.lastname,
	d.departmentname,
	ps.averagenetsalary,
	ts.totalovertimehours,
	ts.totalovertimecost,
	ts.totalabsencedays,
	cast(
		ROUND(
			ts.totalabsencedays *100.0 / ts.totalpossibledays,2)
		AS DECIMAL(10,2)
	)as absencerate

		
from employee e 

inner join department d
	on e.DepartmentID = d.DepartmentID

inner join Timesheetsummary ts
	on e.employeeID = ts.employeeID

inner join payrollsummary ps 
	on e.employeeID = ps.employeeID;


go 

select *
from employeepayrollperformance



