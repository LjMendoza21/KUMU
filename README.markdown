**Code Optimization Overview**

One of the critical change i applied on the code is switching the Storage Engine
from MyISAM to InnoDB. InnoDB has shown to perform better and more reliable over 
MyISAM that makes it a good fit for high performance databases. 

## Key points considered are:
+ InnoDB supports transactions, which means you can commit and roll back. MyISAM does not.
+ InnoDB has row-level locking. This method supports multiple sessions on the same row and table.
  MyISAM only has full table-level locking.This means only one user at a time can alter the table.
+ InnoDB supports foreign keys for referential integrity and relationship constraints, MyISAM does not.
+ InnoDB is more reliable as it uses transactional logs for auto recovery. MyISAM does not.

Several datatypes has also been modified. This is to improve data integrity by ensuring that the correct data/format 
is stored within the tables. Foreign keys are also added to support table relations and helps maintain data integrity
within the database. Other optimization includes omitting redundant columns, proper naming convention(for keys and indexes) 
and data cleansing. Lastly, I've created a stored procedure to populate the employees table to 10,000 records.

**Modifications per table**

## Regions table
+ region_id column in auto increment
+ region_id datatype changed from decimal(5,0) to int
+ data cleansing before import- removed '\r'

## Country table
+ updated region id datatype to int
+ changed index key COUNTR_REG_FK to COUNTR_REG_IX for proper naming convention
+ add foreign key contraint (REGION_FK) for region_id mapped on regions table 
  on cascade update and delete for data integrity checks

## Locations table
+ changed location_id datatype from decimal(4,0) to int
+ add foreign key contraint (COUNTRY_FK) for country_id mapped on countries table
  on cascade update and delete for data integrity checks
+ data cleansing before import 
     - Ox country code replaced by UK, Mexico city " to MX
     - "Distrito Federal to Distrito Federal
     - "Magdalen Centre to Magdalen Centre
     - Switched data for Location_id 2500 columns postal code and City

## Departments table
+ changed department_id datatype from decimal(4,0) to int
+ changed manager_id datatype from decimal(6,0) to int
+ changed location_id datatype from decimal(4,0) to int
+ changed index key DEPT_MGR_FK to DEPT_MGR_IX for proper naming convention
+ add foreign key contraint (LOCATIONS_FK) for locations_id mapped on locations table 
  on cascade update and delete for data integrity checks

## Jobs table
+ changed min_salary datatype from decimal(6,0) to int
+ changed max_salary datatype from decimal(6,0) to int

## Job_history table
+ changed employee_id datatype from decimal(6,0) to int
+ changed department_id datatype from decimal(4,0) to int
+ add foreign key contraint (DEPARTMENT_FK) for department_id mapped on departments table 
  on cascade update and delete for data integrity checks
+ add foreign key contraint (JOB_FK) for job_id mapped on jobs table 
  on cascade update and delete for data integrity checks
+ add foreign key contraint (EMPLOYEE_FK) for employee_id mapped on employees table 
  on cascade update and delete for data integrity checks

## Employees table
+ changed employee_id datatype from decimal(6,0) to int
+ changed department_id datatype from decimal(4,0) to int
+ add foreign key contraint (DEPARTMENTS_FK) for department_id mapped on departments table 
  on cascade update and delete for data integrity checks
+ add foreign key contraint (JOBID_FK) for job_id mapped on jobs table 
  on cascade update and delete for data integrity checks
+ Corrected table relationship. Employee_id column on table employees switched to parent key and 
  employee_id on job_history as the child key. 
+ Deleted hire_date and manager_id columns on employees table (for query optimization, redundant columns)
+ Data Cleansing
      - employee_id 178 from department_id 0 = 10 (integrity checked by Foreign Key)

**Query for top 100 employees resultset**
## Code
	select FIRST_NAME, LAST_NAME,SALARY from employees 
	order by salary desc limit 100;   
	// queries through 10,000 records, completes at about 0.015sec  
