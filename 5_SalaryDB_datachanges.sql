use salaryDB
go

---1) Add A New Employee :
insert into employee
(Firstname,lastname,DepartmentID,JobtitleID,HireDate)

values
('Arman','Amini',4,2,'2026-04-01');

---2) Add A New Employee with Procedure :
drop procedure if exists addnewemployee;

create procedure addnewemployee
	@firstname varchar(50),
	@lastname varchar(50),
	@departmentid int,
	@jobtitleid int,
	@hiredate date
as
begin
	if @departmentid not between 1 and 5
	begin
		throw 50001,'invalid departmentid',1;
	end;

	if @jobtitleid not between 1 and 5
	begin
		throw 50002,'invalid jobtitleid',1;
	end;

	insert into Employee
	(
		Firstname,
		Lastname,
		DepartmentID,
		JobtitleID,
		HireDate
	)
	values
	(
		@firstname,
		@lastname,
		@departmentid,
		@jobtitleid,
		@hiredate
	);
end;
go

exec addnewemployee
	@firstname = 'sara',
	@lastname = 'laleh',
	@departmentid = 6,
	@jobtitleid = 1,
	@hiredate = '2026-04-01';



---3) Update Salary :
update Contract
set BaseSalary = 400000000
where employeeID = 10 ;


---4) Update Basesalary With Procedure :
create procedure IncreaseLowSalaries
	@salarylimit decimal (20,0),
	@increaseamount decimal (20,0)
as
begin

	if @salarylimit <= 0
	begin
		throw 50003,'salary limit must be greater than zero',1;
	end;

	if @increaseamount <= 0
	begin
		throw 50004,'increase amount must be greater than zero',1;
	end;

	declare @employeeCount int;

	select @employeeCount = count(*)
	from contract
	where BaseSalary < @salarylimit;

	if @employeeCount = 0 
	begin
		print 'No employees qualify for salary increase';
	end
	else
	begin
		
		update Contract
		set BaseSalary = BaseSalary + @increaseamount
		where BaseSalary < @salarylimit

		print 'salary update completed';
	end;
end;
go

exec IncreaseLowSalaries
	@salarylimit = 200000000,
	@increaseamount = 30000000;

	