# Employee Payroll & HR Analysis — SQL Server

## 📌 Project Overview

This project is a SQL Server database project for managing and analyzing employee, department, job title, contract, timesheet, and payroll data.

It demonstrates payroll calculations, HR and payroll reporting, data modification using stored procedures, and reusable analytical views.

---

## 🛠 Tech Stack

- SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)

---

## 🧱 Database Structure

The database contains six main tables:

- **Department** — Department information
- **JobTitle** — Job title information
- **Employee** — Employee and organizational information
- **Contract** — Employee contract and salary information
- **Timesheet** — Working days and overtime information
- **Payroll** — Monthly payroll results

### 🔗 Main Relationships

![Database Diagram](diagram.png)

Primary and foreign keys, along with UNIQUE, CHECK, NOT NULL, and DEFAULT constraints, are used to maintain data integrity.

---

## 📊 Business Questions

The project uses SQL to analyze employee distribution, salaries, payroll costs, overtime, and absence rates at both employee and department levels.

It also compares salary and payroll performance and identifies employees and departments with higher salary and overtime costs.

---

## 🧠 Key SQL Skills

### Database Design & Data Integrity

- Relational database design using primary and foreign key relationships
- Identity columns and referential integrity
- Data validation using `NOT NULL`, `UNIQUE`, `CHECK`, and `DEFAULT` constraints

### Data Querying & Manipulation

- Writing structured `SELECT`, `INSERT`, and `UPDATE` statements
- Retrieving data from multiple related tables using `INNER JOIN`
- Filtering, grouping, sorting, and aggregating data

### Data Analysis

- Using `SUM()`, `AVG()`, and `COUNT()` for HR and payroll metrics
- Employee-level and department-level analysis with `GROUP BY`
- Salary, payroll, overtime, and absence calculations

### Advanced SQL

- Common Table Expressions (CTEs) for organizing complex queries
- Window functions such as `RANK()` for salary analysis
- Combining aggregated datasets for employee performance analysis

### Stored Procedures & Data Validation

- Creating parameterized stored procedures for reusable data operations
- Using variables and `IF / ELSE` for conditional logic
- Validating input parameters before modifying data
- Error handling with `THROW`
- Controlled `INSERT` and `UPDATE` operations

### Views

- Creating reusable SQL Views for HR and payroll analysis
- Building analytical datasets for salary, payroll, overtime, and employee performance

---

## 💰 Payroll Calculation

The project calculates:

- Prorated base salary
- Overtime hours and pay
- Gross salary
- Insurance
- Other deductions
- Net salary

The payroll calculation also prevents duplicate payroll records for the same employee and payroll period.

---

## 📊 Reports & Analysis

The project includes reports covering:

- Employee distribution by department and job title
- Monthly payroll and department payroll costs
- Employee salary analysis and ranking
- Overtime hours and overtime costs
- Department-level overtime analysis
- Employee and department absence analysis

---

## ⚙️ Stored Procedures

The project includes stored procedures for:

- Adding new employees with input validation
- Increasing salaries below a specified salary limit

---

## 📈 Analytical Views

The project includes reusable views for:

- Employee details
- Employee and salary information
- Annual salary
- Average employee salary
- Employee payroll summary
- Department monthly payroll
- Employee overtime cost
- Employee payroll performance

---

## ⚠️ Limitations & Assumptions

This project was created primarily for learning and portfolio purposes, so some parts of the system were intentionally simplified:

- Payroll and absence calculations use a 31-day month assumption.
- Salary and payroll rules are simplified.
- Contract data is simplified for the current calculations.
- Department and Job Title data are simplified and fixed for practice purposes.

---

## 🚀 Future Improvements

- Use the actual number of days in each month for payroll and absence calculations.
- Implement more realistic salary and payroll rules.
- Support multiple contracts and active-contract tracking.
- Expand the dataset with more employees and historical records.
- Build a Power BI dashboard for HR and payroll analysis.

---

## 📂 Project Structure

    SalaryDB/
    │
    ├── 1_SalaryDB_Creating tables.sql
    ├── 2_SalaryDB_Inserting Values.sql
    ├── 3_SalaryDB_calculation of payroll.sql
    ├── 4_SalaryDB_Reports.sql
    ├── 5_SalaryDB_datachanges.sql
    └── 6_SalaryDB_Views.sql

---

## ▶️ How to Run

Run the scripts in the following order:

1. `1_SalaryDB_Creating tables.sql`
2. `2_SalaryDB_Inserting Values.sql`
3. `3_SalaryDB_calculation of payroll.sql`
4. `4_SalaryDB_Reports.sql`
5. `5_SalaryDB_datachanges.sql`
6. `6_SalaryDB_Views.sql`

The project can be executed using SQL Server Management Studio (SSMS).
