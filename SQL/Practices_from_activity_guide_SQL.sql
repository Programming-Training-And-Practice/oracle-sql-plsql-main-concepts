--=====================================================================================================
--============================================================================== Practices for Lesson 1
--=====================================================================================================



--=====================================================================================================
--============================================================================== Practices for Lesson 2
--=====================================================================================================

-- 4.
describe departments;
select * from departments;

-- 5.
describe employees;
select * from employees;
-- 5.b
select employee_id, last_name, job_id, hire_date "STARTDATE" 
from employees;

-- 6.
select distinct job_id 
from employees;

-- 7.
select employee_id "Emp #", last_name "Employee", 
       job_id "Job", hire_date "Hire Date" 
from employees;

-- 8.
select last_name || ', ' || job_id "Employee and Title"
from employees;

9.
select employee_id || ',' ||
       first_name || ',' ||
       last_name || ',' ||
       email || ',' ||
       phone_number || ',' ||
       hire_date || ',' ||
       job_id || ',' ||
       salary || ',' ||
       commission_pct || ',' ||
       manager_id || ',' ||
       department_id "THE OUTPUT"
from employees;

--=====================================================================================================
--============================================================================== Practices for Lesson 3
--=====================================================================================================

-- 1.
select last_name, salary
from employees
where salary > 12000;

-- 2.
select last_name, department_id 
from employees
where employee_id = 176;

3.
select last_name, salary 
from employees 
where salary < 5000 or salary > 12000;

-- 4.
select last_name, job_id, hire_date
from employees
where last_name like'Matos' or last_name like 'Taylor'
order by hire_date desc;

-- 5. 
select last_name, department_id
from employees
where department_id = 20 or department_id = 50
order by last_name asc;

-- 6.
select last_name "Employee", salary "Monthly Salary"  
from employees 
where (salary between 5000 and 12000)
and (department_id = 20 or department_id = 50);

-- 7.
select last_name, hire_date
from employees
where to_char(hire_date, 'yyyy') = '2006'; 

-- 8.
select last_name, job_id
from employees
where manager_id is null;

-- 9.
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by 2 desc, 3 desc;

-- 10.
select last_name, salary
from employees
where salary > &salary;

-- 11.
select employee_id, last_name, salary, department_id
from employees
where manager_id = &Manager_id
order by &sort_by;

-- 12.
select last_name 
from employees
where last_name like '__a%';

-- 13.
select last_name 
from employees
where last_name like '%a%' and last_name like '%e%';

-- 14.
SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN ('SA_REP', 'ST_CLERK')
AND salary NOT IN (2500, 3500, 7000);

-- 15.
select last_name "Employee", salary "Monthly Salary", commission_pct 
from employees 
where commission_pct = 0.2;

--=====================================================================================================
--============================================================================== Practices for Lesson 4
--=====================================================================================================

-- 1.
select sysdate "Date" from dual;

-- 2.
select employee_id, 
       last_name, 
       salary, 
       round(salary + ((salary / 100)*15.5)) "New Salary"
from employees;

-- 3.

-- 4.
select employee_id, 
       last_name, 
       salary, 
       round(salary + ((salary / 100)*15.5)) "New Salary",
       round(salary + ((salary / 100)*15.5)) - salary "Increase"
from employees;

-- 5.a
select INITCAP(last_name) "Name", length(last_name) "Length"
from employees
where last_name like 'J%' or last_name like 'A%' or last_name like'M%';

-- 5.b
select INITCAP(last_name) "Name", length(last_name) "Length"
from employees
where last_name like '&START_LETTER%';

-- 5.c
select INITCAP(last_name) "Name", length(last_name) "Length"
from employees
where last_name like upper('&START_LETTER%');

-- 6.
select last_name, round(((sysdate - hire_date) / 30)) MONTHS_WORKED 
from employees
order by round(((sysdate - hire_date) / 30));

-- 7.
select last_name, lpad(salary, 15, '$') SALARY
from employees;

-- 8.
select last_name, rpad(' ', salary / 1000, '*') "EMPLOYEES_AND_THEIR_SALARIES"
from employees
order by salary desc;

-- 9.
select last_name, trunc(((sysdate - hire_date) / 7), 0) "TENURE"
from employees
where department_id = 90
order by TENURE desc;

--=====================================================================================================
--============================================================================== Practices for Lesson 5
--=====================================================================================================

-- 1.
select last_name || ' earns ' || 
       to_char(salary, 'fm$99,999.00') || ' monthly but wants ' || 
       to_char((salary * 3), 'fm$99,999.00') || '.' "Dream Salaries"
from employees;

-- 2.
select last_name, hire_date, salary
from employees;                                                                 -- No esta terminado

-- 3.
select last_name, nvl(to_char(commission_pct), 'No Commission') "COMM"
from employees;

-- 4.
select job_id "JOB_ID", 
  case job_id when 'AD_PRES' then 'A'
              when 'ST_MAN' then 'B'
              when 'IT_PROG' then 'C'
              when 'SA_REP' then 'D'
              when 'ST_CLERK' then 'E'
  else '0' end "GRADE"
from employees;
 
-- 5.
select job_id "JOB_ID", 
  case when job_id = 'AD_PRES' then 'A'
       when job_id = 'ST_MAN' then 'B'
       when job_id = 'IT_PROG' then 'C'
       when job_id = 'SA_REP' then 'D'
       when job_id = 'ST_CLERK' then 'E'
  else '0' end "GRADE"
from employees;

-- 6.
select job_id "JOB_ID", 
       decode(job_id,
              'AD_PRES', 'A',
              'ST_MAN', 'B',
              'IT_PROG', 'C',
              'SA_REP', 'D',
              'ST_CLERK', 'E',
              '0') "GRADE"
from employees;

--=====================================================================================================
--============================================================================== Practices for Lesson 6
--=====================================================================================================

-- 1.
-- True

-- 2.
-- False

-- 3.
-- True

-- 4.
select max(salary) "Maximum", 
       min(salary) "Minimum",
       sum(salary) "Sum", 
       round(avg(salary)) "Average"
from employees;

-- 5.
select job_id, 
       max(salary) "Maximum", 
       min(salary) "Minimum",
       sum(salary) "Sum", 
       round(avg(salary)) "Average"
from employees
group by job_id;

-- 6.
select job_id, count(*)
from employees
group by job_id;

select job_id, count(*)
from employees
where job_id = '&job_id'
group by job_id;

-- 7.
SELECT COUNT(DISTINCT manager_id) "Number of Managers"
FROM employees;


-- 8.
select (max(salary) - min(salary)) "DIFFERENCE"
from employees;

-- 9.
select manager_id, min(salary)
from employees
group by manager_id
having manager_id is not null and min(salary) > 6000
order by min(salary) desc;

SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) > 6000
ORDER BY MIN(salary) DESC;

-- 10.
-- CASE
select count(distinct hire_date), 
       sum(case to_char(hire_date, 'yyyy') when '2005' then 1 else 0 end) "2005",
       sum(case to_char(hire_date, 'yyyy') when '2006' then 1 else 0 end) "2006",
       sum(case to_char(hire_date, 'yyyy') when '2007' then 1 else 0 end) "2007",
       sum(case to_char(hire_date, 'yyyy') when '2008' then 1 else 0 end) "2008"
from employees;
-- DECODE()
select count(distinct hire_date), 
       sum(decode(to_char(hire_date, 'yyyy'), '2005', 1, 0)) "2005",
       sum(decode(to_char(hire_date, 'yyyy'), '2006', 1, 0)) "2006",
       sum(decode(to_char(hire_date, 'yyyy'), '2007', 1, 0)) "2007",
       sum(decode(to_char(hire_date, 'yyyy'), '2008', 1, 0)) "2008"
from employees;

-- 11.
-- DECIDE()
select job_id, 
       sum(decode(department_id, 20, salary)) "Dept 20",
       sum(decode(department_id, 50, salary)) "Dept 50",
       sum(decode(department_id, 80, salary)) "Dept 80",
       sum(decode(department_id, 90, salary)) "Dept 90",
       sum(salary) "Total"
from employees
group by job_id;
-- CASE
select job_id, 
       sum(case department_id when 20 then salary else 0 end) "Dept 20",
       sum(case department_id when 50 then salary else 0 end) "Dept 50",
       sum(case department_id when 80 then salary else 0 end) "Dept 80",
       sum(case department_id when 90 then salary else 0 end) "Dept 90",
       sum(salary) "Total"
from employees
group by job_id;


--=====================================================================================================
--============================================================================== Practices for Lesson 7
--=====================================================================================================




--=====================================================================================================
--============================================================================== Practices for Lesson 8
--=====================================================================================================






--=====================================================================================================
--============================================================================== Practices for Lesson 9
--=====================================================================================================




--======================================================================================================
--============================================================================== Practices for Lesson 10
--======================================================================================================




--======================================================================================================
--============================================================================== Practices for Lesson 11
--======================================================================================================