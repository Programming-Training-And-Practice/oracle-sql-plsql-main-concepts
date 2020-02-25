
select employee_id, first_name, job_id, department_id from employees where department_id = 90;


INSERT INTO employees VALUES (300, 'Jesus', 'Rodeiguez', 'jesusrodriguez@email', 5151238181, '07-JUN-19', 'AC_ACCOUNT', 20300, 0.5, 205, 110);
update employees set phone_number = 5151238181 where employee_id = 207;
update employees set first_name = 'Wil_liam' where employee_id = 207;
commit;



select first_name, salary * commission_pct from employees where first_name; 


select * from employees;


-- ======================================================================================================================================================

select first_name ||' '|| last_name "Full Name", salary, d.department_id, department_name "Department", city from employees e 
join departments d 
on d.department_id = e.department_id 
join locations l 
on d.location_id = l.location_id;

select first_name ||' '|| last_name "Full Name", salary, d.department_id, department_name "Department", city from employees e 
join departments d 
on d.department_id = e.department_id;



select e.last_name, e.manager_id, j.last_name 
from employees e 
join employees j 
on j.employee_id = e.manager_id;

select e.last_name, e.manager_id, j.last_name 
from employees e 
join employees j 
on e.manager_id = j.employee_id;

select first_name, last_name from employees;
