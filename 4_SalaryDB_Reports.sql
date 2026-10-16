use salaryDB
go 

---HR Reports :
--1) Total number of employees :
select 
	count(*) as TotalNumberOfEmployees
from Employee;

--2) Employees by department :
select 
	d.departmentname,
	count (e.employeeID) as employeecount
from department d
inner join employee e
	on d.DepartmentID = e.DepartmentID
group by
	d.Departmentname;

--3) counting employees by job title :
select
	j.jobname,
	count(e.employeeid) as employeecount
from Jobtitle j
inner join Employee e 
	on j.JobtitleID = e.JobtitleID
group by
j.Jobname;

--4) counting employees by department + jobtitle :
select
	d.departmentname,
	j.jobname,
	count (e.employeeid) as employeecount
from employee e
inner join department d
	on e.DepartmentID = d.DepartmentID
inner join Jobtitle j
	on e.JobtitleID = j.JobtitleID
group by 
	d.Departmentname,
	j.Jobname
order by 
	d.Departmentname,
	employeecount desc;


---Payroll Reports :
--1) Total Payroll By Month :
select 
	payyear,
	paymonth,
	sum(grosssalary) as totalgrosssalary,
	sum(insurance) as totalinsurance,
	sum(otherdeduction) as totalotherdeduction,
	sum(netsalary) as totalnetsalary
from Payroll
group by
	PayYear,
	paymonth
order by
	PayYear,
	PayMonth;

--2) Employee Salary Ranking :
select
	e.employeeid,
	e.firstname,
	e.lastname,
	p.paymonth,
	p.payyear,
	p.netsalary
from payroll p
inner join employee e
	on p.employeeID = e.employeeID
order by
	p.NetSalary desc;

--3) Payroll Cost By Department :
select
	d.departmentname,
	sum(p.grosssalary) as totalgrosssalary,
	sum(p.netsalary) as totalnetsalary
from payroll p
inner join employee e
	on e.employeeID = p.employeeID
inner join department d
	on e.DepartmentID = d.DepartmentID
group by
	d.Departmentname
order by
	totalnetsalary desc;

--4) Highest Paid Employee In Each Department :
with rankedemployees as
(
	select
	d.departmentname,
	e.employeeid,
	e.firstname,
	e.lastname,
	p.netsalary,

	rank() over
	(
		PARTITION by d.departmentname
		order by p.netsalary desc
		) as SalaryRank
	from payroll p
	inner join employee e
		on p.employeeID = e.employeeID
	inner join department d
		on e.DepartmentID = d.DepartmentID
)
select
	departmentname,
	employeeid,
	firstname,
	lastname,
	netsalary
from rankedemployees
where SalaryRank = 1
order by 
	Departmentname;
--5) Calculating Average Netsalary Then Show Highest Paid Employee :
with employeeaveragepay as 
(
	select
		e.employeeid,
		e.firstname,
		e.lastname,
		d.departmentname,
		
		avg(p.netsalary) as averagenetpay

	from payroll p

	inner join employee e
		on e.employeeID = p.employeeID

	inner join department d
		on e.DepartmentID = d.DepartmentID

	group by 
		e.employeeID,
		e.Firstname,
		e.Lastname,
		d.Departmentname
),

rankedemployees as
(
	select
		employeeid,
		firstname,
		lastname,
		Departmentname,
		averagenetpay,

		rank() over
		(
			partition by departmentname
			order by averagenetpay desc
		) as salaryrank
	from employeeaveragepay
)
select
	departmentname,
	employeeid,
	firstname,
	lastname,
	averagenetpay
from rankedemployees
where salaryrank = 1
order by 
	averagenetpay desc;



---Timesheet Reports :
--1) Working Days By Employee:
select
	e.employeeid,
	e.firstname,
	e.lastname,
	t.workmonth,
	t.workyear,
	t.workingdays

from timesheet t
inner join employee e
	on e.employeeid = t.employeeID
	
order by 
	t.WorkYear,
	t.workmonth,
	t.WorkingDays desc;



--2) Overtime Hours By Employees :
select
	e.employeeid,
	e.firstname,
	e.lastname,
	
	sum (t.overtimeminutes)/60 as totalovertimehour

from Timesheet t
inner join employee e 
	on e.employeeID = t.employeeID

group by
	e.employeeID,
	e.Firstname,
	e.Lastname
order by
	totalovertimehour desc;


--3) Overtime Hours By Department :
select
	d.departmentname,
	sum(t.OvertimeMinutes)/60 AS totalovertimehour

from Timesheet t
inner join Employee e
	on e.employeeID = t.employeeID

inner join Department d
	on e.DepartmentID = d.DepartmentID

group by 
	d.Departmentname
order by 
	totalovertimehour desc;


---4) Overtime Hours By departments In Each Month :
select 
	d.departmentname,
	t.workyear,
	t.workmonth,

	sum(t.overtimeminutes)/60 AS totalovertimehours

from Timesheet t 

inner join employee e
	on e.employeeID = t.employeeID

inner join department d
	on d.DepartmentID = e.DepartmentID

group by 
	d.Departmentname,
	t.WorkYear,
	t.WorkMonth
order by 
	t.WorkYear,
	t.WorkMonth,
	totalovertimehours desc;


--5) Overtime Cost By Department And Month :
select 
	d.departmentname,
	t.workyear,
	t.workmonth,

	cast(
		round(
			sum(
				((c.basesalary /31.0) / 8.0)
				*(t.overtimeminutes/60.0)
			),
			0
		)
		as decimal (20,0)
	) as totalovertimeCost

from Timesheet t

inner join employee e
	on e.employeeID = t.employeeID

inner join department d 
	on e.DepartmentID = d.DepartmentID

inner join contract c
	on e.employeeID = c.employeeID

group by 
	d.Departmentname,
	t.WorkYear,
	t.WorkMonth

order by 
	t.WorkYear,
	t.WorkMonth,
	totalovertimeCost desc;



--6) Absence Rate By Department :
select	
	d.departmentname,

	sum(31-t.workingdays) as totalabsencedays,

	count(*) * 31 as totalworkingdays,

	round(
		(sum(31-t.workingdays)*100) /(count(*) * 31),
		2
	) as absencerate

from Timesheet t

inner join employee e
	on e.employeeID = t.employeeID

inner join department d
	on e.DepartmentID = d.departmentid

group by 
	d.Departmentname

order by 
	absencerate desc;
