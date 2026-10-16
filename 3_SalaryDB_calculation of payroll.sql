---calculation-payroll:
use salaryDB
go
with payrollcalculation as
(
Select
	e.employeeid,
	e.firstname,
	e.lastname,
	c.basesalary,
	c.fixedallowance,
	c.additionalallowance,
	t.WorkMonth,
	t.WorkYear,
	t.workingdays,
	t.overtimeminutes,

---calculating daily salary :
c.BaseSalary/31.0
	as DailySalay,

---calculating base salary according to actual working days :
(c.BaseSalary / 31.0)* t.WorkingDays
	as ProratedBaseSalary,

---convert over time minute to hour :
t.OvertimeMinutes / 60.0
	as overtimehour,

--- calculating hourly salary :
(c.BaseSalary / 31.0) / 8.0
	as hourlysalary,

---calculating over time payment :
((c.BaseSalary / 31.0) / 8.0)*(t.OvertimeMinutes / 60.0)
as overtimepay,

---calculating gross salary :
round (
(c.basesalary / 31.0)*t.workingdays
+ c.fixedallowance
+ c.additionalallowance
+ ((c.basesalary / 31.0)/8.0)*(t.overtimeminutes / 60.0),
0)
as grosssalary

from Employee e
inner join Contract c
	ON E.employeeID = C.employeeID

INNER JOIN Timesheet T
	ON E.employeeID = T.employeeId
)

---inserting values into payroll :
insert into Payroll
(
employeeID,
PayMonth,
PayYear,
GrossSalary,
Insurance,
OtherDeduction,
NetSalary)

---calculating net salary :
select 
pc.employeeid,
pc.workmonth,
pc.workyear,
pc.grosssalary,

10000000 as insurance,
5000000 as otherdeduction,
pc.grosssalary -10000000-5000000 as netsalary

from payrollcalculation pc
where not exists
(
	select 1
	from payroll p
	where p.employeeID = pc.employeeID
	and p.paymonth = pc.workmonth
	and p.PayYear = pc.workyear);

---check :
select *
from Payroll;


