--==========================================================================================================================================================
--============================================================================================================================================== INSERT INTO
--==========================================================================================================================================================

-- Para insertar charactes y fecha se usan comillas simples
insert into departments
(department_id, department_name, manager_id, location_id)
values(70, 'Public Relations', 100, 1700);

-- La informacion insertada va aparecer solo en esta sesion que 
-- actualmente estamos trabajando.
-- Para que se guarde informacion insertada al base de datos y para que se puede
-- leer los datos insertados desde otros sesiones hace falta hacer comando 'COMMIT'

-- Cuando se hace inset into no es obligatorio rellenar todos campos de tabla
-- Obligatorio poner aquellos campos que no haceptan valores nullos, campos que 
-- tienen puesto configuracion 'NOT NULL'

-- Los nombres de columnas que no aparecen en 'campos de tabla que hace falta rellenar' 
-- y en 'values'  se rellenan con valores nulos.
insert into departments
(department_id, department_name)
values(30,'Purchasing');

-- No es necesario describir los campos de tabla que queres rellenar
insert into departments
values(100,'Finance');

insert into departments
values(100,'Finance', null, null);

INSERT INTO employees
(employee_id, first_name, last_name, email, phone_number,
 hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES(113, 'Louis', 'Popp', 'LPOPP', '515.124.4567', 
       CURRENT_DATE, 'AC_ACCOUNT', 6900, NULL, 205, 110);

-- Con ayuda de funccion to_date nos podemos poner la fecha al correcto formato
INSERT INTO employees
VALUES(114, 'Den', 'Raphealy', 'DRAPHEAL', '515.127.4561',
       TO_DATE('FEB 3, 2003', 'MON DD, YYYY'), 'SA_REP', 11000, 0.2, 100, 60);
       
------------------------------------------------------------------------------------------------------------------ substitution
INSERT INTO departments
(department_id, department_name, location_id)
VALUES(&department_id, '&department_name',&location);     
       
       
       
       
select * from employees order by employee_id;
select * from departments order by department_id;
--==========================================================================================================================================================
--============================================================================================================================================== 
--==========================================================================================================================================================





--==========================================================================================================================================================
--=================================================================================================================================================== Others
--==========================================================================================================================================================
-- Asi se puede entrar al SQLPlus, improduciendo comando 'sqlplus ususario/contrasena'
-- sqlplus ora1/ora1