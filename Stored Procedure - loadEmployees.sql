DELIMITER $$
DROP PROCEDURE IF EXISTS loadEmployees$$
create procedure loadEmployees(
)
	begin
	 declare rid int;
	 declare c int;
     declare c1 int;
     declare i int;
     declare var varchar(4);
     set rid = 100;
     set c = 207;
     set c1 = 1;
     set i = 65;
        
		while c < 10100 do
        
         if c1 <= 2650 then
			set var = char(i);
		 elseif c1>2650 and c1<5301 then
			set var = concat(char(i),char(i));
		 elseif c1>5300 and c1<=7951 then
			set var = concat(char(i),char(i),char(i));
		 elseif c1>7950 and c1<=10100 then
			set var = concat(char(i),char(i),char(i),char(i));
		 end if;
        
			insert into `employees` (`EMPLOYEE_ID`, `FIRST_NAME`, `LAST_NAME`, `EMAIL`, `PHONE_NUMBER`, `JOB_ID`, `SALARY`, `COMMISSION_PCT`, `DEPARTMENT_ID`)
				select c, concat(FIRST_NAME,var), concat(LAST_NAME,var), concat(EMAIL,var), PHONE_NUMBER, JOB_ID, SALARY + c1, COMMISSION_PCT, DEPARTMENT_ID
					from employees_temp where EMPLOYEE_ID= rid;
				set c = c + 1;
                set c1 = c1 + 1;	
                set rid = rid + 1;
                
             if rid>206 then
                set rid = 100;
                set i = i + 1;
			end if;
            
            if i>90 then
				set i = 65;
			end if;
            
		 end while;
	END; $$
 DELIMITER ;   
 
 

