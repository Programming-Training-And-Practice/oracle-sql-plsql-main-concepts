-- Este archivo contiene varias querys y comentarios sobre ellas mismas. 
-- Es probable que estos querys puede servir para alguien para repasar algunas 
-- cosas de SQLOracle. 
-- ATENCION estos querys y comentarios sobre querys pueden ser erróneas, es solo 
-- mis notas durante los estudios.
-- A este archivo se va agregar mas querys, durante los estudios.
-- Un saludo a todos. 
-- Espero que os sirve para algo.
-- TRL

--==========================================================================================================================================================
--====================================================================================================================================== General informarion
--==========================================================================================================================================================

--The Oracle server evaluates the clauses in the following order:
--      1. If the statement contains a WHERE clause, the server establishes the 
--         candidate rows.
--      2. The server identifies the groups that are specified in the 
--         GROUP BY clause.
--      3. The HAVING clause further restricts result groups that do not meet 
--         the group criteria in the HAVING clause.

--==========================================================================================================================================================
--==================================================================================================================================================== Alias
--==========================================================================================================================================================

-- alias = NAME 
select last_name as Name 
from employees;     

-- se permite poner un alias si usar palabra clave 'as'. Palabra clave 'as' no 
-- es obligatoria.
select last_name Name 
from employees;

-- Si hace falta guardar registro de letras en alias, alias tiene que estar 
-- dentro de comillas dobles.
-- alias = Name
select last_name "Name" 
from employees;    

-- Si alias contiene espacio o varios espacios es obligatorio poner alias entre 
-- comillas dobles
select last_name "Name Employee" 
from employees;

-- Dentro de alias no se permite poner comillas simples
select last_name "Alias que lleva co'milla simple" 
from employees;                                                                 -- Error

--==========================================================================================================================================================
--============================================================================================================================================ Concatenation
--==========================================================================================================================================================

------------------------------------------------------------------------------------------------------------------
--                                                                                                String || String

select first_name || last_name "Employee"  
from employees;

------------------------------------------------------------------------------------------------------------------
--                                                                                     String || Literal || String

select first_name || ' ' || last_name "Employee" 
from employees;

select 123, first_name || ' ' || last_name "Employee" 
from employees;

select 123 || first_name || ' ' || last_name "Employee" 
from employees;

------------------------------------------------------------------------------------------------------------------
--                                                                                                String || Number

select first_name || ' ' || salary "Employee and Salary" 
from employees;

------------------------------------------------------------------------------------------------------------------
--                                                                                            String || Date(fecha)

select first_name || ' ' || hire_date "Employee and Start Date" 
from employees;

------------------------------------------------------------------------------------------------------------------
--                                                                                        String || double or Null

-- Este output es interesante.
select first_name || ' ' || commission_pct "Employee and Commission", 
       commission_pct 
from employees;

select '<' || first_name || '' || commission_pct || '>' "Employee and Commission", 
       commission_pct 
from employees;

select '<' || 'algo' || null || '>' from dual;

--==========================================================================================================================================================
--========================================================================================================================== Operaciones aritmetics: + - * / 
--==========================================================================================================================================================

select last_name, salary, 12 * salary + 100 
from employees;

select last_name, salary, 12 * (salary + 100) 
from employees;

select last_name, salary, - salary + 100 
from employees;

------------------------------------------------------------------------------------------------------------------
--                                                                                          Error division bu zero
select 5 / 0 from dual;                                                         -- Error  

select 0 / 8 from dual;                                                         -- NOT ERROR

--==========================================================================================================================================================
--==================================================================================================================================================== WHERE
--==========================================================================================================================================================

------------------------------------------------------------------------------------------------------------------
--                                                                                            WHERE con Characters

select last_name, department_id 
from employees 
where last_name = 'King';

select last_name, department_id 
from employees 
where last_name = 'king';

select last_name, department_id 
from employees 
where last_name = 'KING';

------------------------------------------------------------------------------------------------------------------
--                                                                                                 WHERE con Fecha

select last_name, hire_date 
from employees 
where hire_date = '17-JUN-03';

select last_name, hire_date 
from employees 
where hire_date = '17-jun-03';

------------------------------------------------------------------------------------------------------------------
--                                                                        Mas de dos condinciones en causula WHERE

-- Como se puede usar dos condinciones a la ves
select last_name "Employee", salary "Monthly Salary"  
from employees 
where (salary between 5000 and 12000)
and (department_id = 20 or department_id = 50);

------------------------------------------------------------------------------------------------------------------
--                                                                                                  WHERE con NULL

select last_name, commission_pct  
from employees 
where commission_pct is null;

select last_name, commission_pct  
from employees 
where commission_pct is not null;

-- Campos por defecto se rellenen con NULL no con ZERO
select last_name, commission_pct  
from employees 
where commission_pct = 0;

--==========================================================================================================================================================
--=============================================================================================================================================== Conditions
--==========================================================================================================================================================

--   <
--   >
--   <=
--   >=
--   =
--   <>
--   !=
--   ^=

------------------------------------------------------------------------------------------------------------------
--                                                                                         Condiciones con numeros

--   <
select last_name, salary 
from employees 
where salary <  6000;

--   >
select last_name, salary 
from employees 
where salary >  6000;

--  <=
select last_name, salary 
from employees 
where salary <=  6000;

--  >=
select last_name, salary 
from employees 
where salary >=  6000;

--  <>
select last_name, salary 
from employees 
where salary <>  17000;

--  !=
select last_name, salary 
from employees 
where salary !=  17000;

--  ^=
select last_name, salary 
from employees 
where salary ^=  17000;

------------------------------------------------------------------------------------------------------------------
--                                                                                           Condiciones con fecha

select last_name, hire_date 
from employees 
where hire_date <= '17-jun-03';

select last_name, hire_date 
from employees 
where hire_date >= '17-jun-03';

select last_name, hire_date 
from employees 
where hire_date > '17-jun-03';

------------------------------------------------------------------------------------------------------------------
--                                                                                      Condiciones con characters

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar informacion
-- No se como funcciona
-- ?????????????????
select last_name, department_id 
from employees 
where last_name < 'King';

select last_name, department_id 
from employees 
where last_name > 'King';

select last_name, department_id 
from employees 
where last_name <= 'King';

------------------------------------------------------------------------------------------------------------------
--                                                                                            Condiciones con NULL

-- Condiciones no funccionen con NULL, como values por defecto
select last_name, commission_pct 
from employees 
where commission_pct = null;

select last_name, commission_pct 
from employees 
where commission_pct > null;

------------------------------------------------------------------------------------------------------------------
--                                                                                            Condiciones con ZERO

select last_name, commission_pct 
from employees 
where commission_pct <> 0;

select last_name, commission_pct 
from employees 
where commission_pct != 0;

select last_name, commission_pct 
from employees 
where commission_pct > 0;

-- No sale ningun resultado, no funcciona
select last_name, commission_pct 
from employees 
where commission_pct = 0;

--==========================================================================================================================================================
--================================================================================================================================================== BETWEEN
--==========================================================================================================================================================

-- Remember to specify the low value first and the high value last when using 
-- the BETWEEN condition. The Oracle server translates the BETWEEN condition to 
-- a pair of AND conditions.

------------------------------------------------------------------------------------------------------------------
--                                                                                             BETWEEN con numeros

-- Van aparecer todos salary que se encuentren entere 10500 y 17000, incluso los 
-- salary que estan igual al 10500 y 17000 
select last_name, salary 
from employees 
where salary 
between 10500 
and 17000;

-- Asi a esta manera no nos va aparecer ningun resultado
select last_name, salary 
from employees 
where salary
between 17000 and 10500;

-- Aparecen todos resultados
select last_name, salary 
from employees 
where salary 
between -10 and 1000000000000000000;

------------------------------------------------------------------------------------------------------------------
--                                                                                               BETWEEN con fecha

select last_name, hire_date 
from employees 
where hire_date
between '17-jun-03' and '17-jun-04';

------------------------------------------------------------------------------------------------------------------
--                                                                                          BETWEEN con characters
select last_name
from employees 
where last_name
between 'Abel' and 'Grant';

select last_name from employees;

--==========================================================================================================================================================
--======================================================================================================================================================= IN
--==========================================================================================================================================================

------------------------------------------------------------------------------------------------------------------
--                                                                                                  IN con numeros

select employee_id, last_name, salary, manager_id 
from employees 
where manager_id in(100, 101, 201);

------------------------------------------------------------------------------------------------------------------
--                                                                                                   IN con fechas

select last_name, hire_date 
from employees 
where hire_date in('17-jun-03', '17-oct-03 ', '17-sep-03');

------------------------------------------------------------------------------------------------------------------
--                                                                                               IN con characters

select last_name 
from employees 
where last_name in('King', 'Rajs', 'Whalen');

------------------------------------------------------------------------------------------------------------------
--                                                                                                   IN con nullos

-- IN con nullos no funcciona 
select last_name, commission_pct 
from employees 
where commission_pct in(null);

--==========================================================================================================================================================
--===================================================================================================================================================== LIKE 
--==========================================================================================================================================================

------------------------------------------------------------------------------------------------------------------
--                                                                                             LIKE con characters

select last_name from employees where last_name like 'K%';

select last_name from employees where last_name like '%s';

select last_name from employees where last_name like '______s';

select last_name from employees where last_name like '%ig%';

select last_name from employees where last_name like '_a%';

select last_name from employees where last_name like '%e_';

select last_name from employees where last_name like '_A%';

------------------------------------------------------------------------------------------------------------------
--                                                                                                LIKE con numeros

-- Se permite buscar los numeros tambien
select last_name, salary 
from employees 
where salary like '24%';

select last_name, salary 
from employees 
where salary like '4%';

select last_name, salary 
from employees 
where salary like '_6%';

select last_name, commission_pct 
from employees 
where commission_pct like '0.2';

------------------------------------------------------------------------------------------------------------------
--                                                                                                  LIKE con Fecha

-- Se permite buscar las fechas tambien
select last_name, hire_date 
from employees 
where hire_date like '17%';

select last_name, hire_date 
from employees
where hire_date like '___JUN%';

select last_name, hire_date 
from employees 
where hire_date like '_______04%';

------------------------------------------------------------------------------------------------------------------
--                                                                                                 LIKE con NULLOS

-- No se permite buscar los canopos Nullos con LIKE. Los campos nullos se buscan
--con palabras claves 'IS NULL' y 'IS NOT NULL'
select last_name, commission_pct 
from employees 
where commission_pct like 'Null';                                               

select last_name, commission_pct 
from employees 
where commission_pct like 'null';                                               

select last_name, commission_pct 
from employees 
where commission_pct like ' ';

------------------------------------------------------------------------------------------------------------------

-- Interesante cosa, nos sale output casi de todos empleados.
select last_name 
from employees 
where last_name like '%_%';

select '<' || last_name || '>'
from employees 
where last_name like '%_%';

------------------------------------------------------------------------------------------------------------------

-- screening экранирование
-- Screening, pero no me funcciona estos exemplos.
select first_name 
from employees 
where first_name like '%/_%'; escape '\';

select first_name 
from employees 
where first_name like '%/%%'; escape '\';

select first_name 
from employees 
where first_name like '%1_%'; escape '1';

------------------------------------------------------------------------------------------------------------------

select last_name, job_id, hire_date
from employees
where last_name like'Matos' or like 'Taylor';                                   -- ERROR

select last_name, job_id, hire_date
from employees
where last_name like'Matos' or last_name like 'Taylor';                         -- NOT ERROR

------------------------------------------------------------------------------------------------------------------ 
--                                                                             LIKE con 'Variable de substitution'  

select INITCAP(last_name) "Name", length(last_name) "Length"
from employees
where last_name like upper('&START_LETTER%');

--==========================================================================================================================================================
--===================================================================================================================================================== NULL 
--==========================================================================================================================================================
-- Campos rellenos con valor Null
select last_name, job_id, commission_pct from employees;

-- Campo com valor numerico multiplicar por null la resumen es Null
select last_name, salary * commission_pct from employees;

select last_name "Name", salary * nvl(commission_pct, 1) "Salary and Commission" 
from employees;

-- Campo com valor numerico sumar null la resumen es Null
select last_name, salary + commission_pct from employees;

-- Campo com valor numerico restar null la resumen es Null
select last_name, salary - commission_pct from employees;

-- Campo com valor numerico dividir por null la resumen es Null
select last_name, salary / commission_pct from employees;

-- Si campo que lleva valor null multiplicar por algun valor numerico, la resumen 
-- va ser Null. Ejamplo abajo.
select last_name, salary, commission_pct, 12 * salary as "Salary year", 
(12 * salary) * commission_pct as "Salary year and Commission"  from employees;

-- Si campo que lleva valor null concatenar con algun valor String, la resumen va 
-- ser String concatenado con espacio en blanco. Ejamplo abajo.
select last_name || ', ' || commission_pct || ',' from employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                     IS NOT NULL

select last_name, salary, commission_pct
from employees
where commission_pct is not null;

------------------------------------------------------------------------------------------------------------------ substr() con campos NULL 
select last_name, substr(commission_pct, 1) from employees;
select last_name, substr(commission_pct, 1, 3) from employees;
-- Atencion
select last_name, substr(commission_pct, 5) from employees;

--==========================================================================================================================================================
--================================================================================================================================================== IS NULL 
--==========================================================================================================================================================
select first_name, commission_pct 
from employees 
where commission_pct is null;

-- No funcciona, output esta vacio.
select first_name, commission_pct 
from employees 
where commission_pct = null;    

select first_name, commission_pct 
from employees 
where commission_pct is not null;

select last_name, job_id
from employees
where manager_id is null;

--==========================================================================================================================================================
--================================================================================================================================================== Literal 
--==========================================================================================================================================================
select * from employees where hire_date = '17-JUN-03';

-- Da mismo resultado que con 'jun' en maysculas.
select * from employees where hire_date = '17-jun-03';

-- Hay que tener quidado con el formato de fecha que esta puesto por defecto.
select * from employees where hire_date = '17-06-03';

-- Este query no devolve nada, la primera letra de Nobre esta en incorrecto 
-- registro(esta en menyscula, 
-- a tiene que ser en mayscula)
select * from employees where last_name = 'king';

-- Este query si devuelve la respuesta.
select * from employees where last_name = 'King';

-- String || Literal || String
select first_name || ' ' || last_name "Employee" from employees;

-- Literal || String || String
select 123, first_name || ' ' || last_name "Employee" from employees;

-- Literal || String || String
select 123 || first_name || ' ' || last_name "Employee" from employees;

-- Comilla simple
select 'Nombre''Apellido' from dual;

select 'Nombre' 'Apellido' from dual;                                           -- Error

select 'Nombre' || 'Apellido' from dual;                                        -- Not Error

------------------------------------------------------------------------------------------------------------------
--                                                                                    Ekranirovanie s pomowchy q[ ]

--select 'Literal que lleva co'milla simple' from dual;                         -- Error

select q'[Literal que lleva co'milla simple]' from dual;                        -- Not Error

select q'[Li'te'ral que lle'va co'milla sim'ple]' from dual;                    -- Not Error

select q'(Literal que lleva co'milla simple)' from dual;   

select q'!Literal que lleva co'milla simple!' from dual;                        -- Not Error
  
select q'*Literal que lleva co'milla simple*' from dual;                        -- Not Error

select q'-Literal que lleva co'milla simple-' from dual;                        -- Not Error

select q'_Literal que lleva co'milla simple_' from dual;                        -- Not Error

select q'1Literal que lleva co'milla simple1' from dual;                        -- Not Error

--==========================================================================================================================================================
--================================================================================================================================================= DISTINCT 
--==========================================================================================================================================================

-- COUNT(DISTINCT expr) returns the number of distinct non-null values of expr.

-- Use the DISTINCT keyword to suppress the counting of any duplicate values 
-- in a column.

select distinct department_id from employees;

select first_name, distinct salary from employees;                              -- Error

select distinct first_name, salary from employees;  

select distinct salary, first_name from employees;

select distinct last_name, first_name from employees;

select count(distinct department_id) from employees;

--==========================================================================================================================================================
--============================================================================================================================================ DESC DESCRIBE 
--==========================================================================================================================================================
desc employees;

describe employees;

--==========================================================================================================================================================
--====================================================================================================================================================== AND 
--==========================================================================================================================================================
select employee_id, last_name, job_id, salary 
from employees 
where salary >= 10000 
and job_id 
like '%MAN%';

--==========================================================================================================================================================
--======================================================================================================================================================= OR 
--==========================================================================================================================================================
select employee_id, last_name, job_id, salary from employees 
where salary >= 10000 
or  job_id like '%MAN%';

--==========================================================================================================================================================
--====================================================================================================================================================== NOT 
--==========================================================================================================================================================
select first_name, commission_pct 
from employees
where commission_pct is not null;

select last_name, job_id 
from employees 
where job_id not in ('IT_PROG', 'ST_CLERK', 'SA_REP');

--==========================================================================================================================================================
--=================================================================================================================================== Operational Priorities 
--==========================================================================================================================================================
select last_name, job_id, salary from employees 
where job_id = 'SA_REP' 
or job_id = 'AD_PRES' 
and salary > 15000;

select last_name, job_id, salary from employees 
where (job_id = 'SA_REP' 
       or job_id = 'AD_PRES') 
and salary > 15000;

--==========================================================================================================================================================
--================================================================================================================================================= ORDER BY 
--==========================================================================================================================================================

-- Place the HAVING and GROUP BY clauses after the WHERE clause in a statement. 
-- The order of the GROUP BY and HAVING clauses following the WHERE clause is not 
-- important. You can have either the GROUP BY clause or the HAVING clause first 
-- as long as they follow the WHERE clause. Place the ORDER BY clause at the end.

-- ASC esta puesto por defecto
select last_name, job_id, department_id, hire_date 
from employees
order by hire_date; 
 
select last_name, job_id, department_id, hire_date 
from employees 
order by hire_date asc;

select last_name, job_id, department_id, hire_date 
from employees 
order by hire_date desc;

------------------------------------------------------------------------------------------------------------------ 

-- ORDER BY se pone al final de la query(expression)
select employee_id, last_name, job_id, salary
from employees 
where salary >= 10000 or  job_id like '%MAN%' 
order by salary;

--  ERRPR,  ORDER BY tiene que estar al final de la expression,
select last_name, salary
from employees 
where salary >=  6000 
order by salary and last_name like 'G%';                                        -- Error

------------------------------------------------------------------------------------------------------------------ 

-- Se permite ordenar reusltados por varias cosas. Ejemplo abajo. 
select last_name, job_id, salary, department_id 
from employees 
order by department_id, salary desc;

select last_name, job_id, salary, department_id from employees 
order by department_id desc, salary desc;

------------------------------------------------------------------------------------------------------------------ 

-- Se permite ordenar por campo que no se encuentra en select, por ejemplo job_id
select last_name, salary 
from employees 
order by job_id;

------------------------------------------------------------------------------------------------------------------ 

-- Se permite usar alias con ORDER BY 
select last_name, job_id, department_id, hire_date StartDate 
from employees 
order by StartDate;

-- Y se permite no usasr alias
select last_name, job_id, department_id, hire_date StartDate 
from employees 
order by hire_date; 

------------------------------------------------------------------------------------------------------------------ 

-- Tambien se puede usar numero de columna en ORDER BY. Por ejemplo la columna 
-- hire_date se encuentra en puesto 4
select last_name, job_id, department_id, hire_date StartDate
from employees 
order by 4; 

select last_name, job_id, department_id, hire_date StartDate
from employees 
order by 3, 4;

------------------------------------------------------------------------------------------------------------------ 

-- Los values Nullos estan ultimos por defecto
select last_name, job_id, department_id, hire_date StartDate 
from employees 
order by department_id;

-- Los values Nullos estan ultimos
select last_name, job_id, department_id, hire_date StartDate 
from employees 
order by department_id nulls last;

-- Los values Nullos estan primeros
select last_name, job_id, department_id, hire_date StartDate 
from employees 
order by department_id nulls first;

------------------------------------------------------------------------------------------------------------------ 

-- Palabra clave 'DESC' tiene que esta al final de ORDER BY
select last_name, job_id, hire_date
from employees
where last_name like'Matos' or last_name like 'Taylor'
order by desc hire_date;                                                        -- ERROR

select last_name, job_id, hire_date
from employees
where last_name like'Matos' or last_name like 'Taylor'
order by hire_date desc;                                                        -- NOT ERROR

------------------------------------------------------------------------------------------------------------------ 

-- No estoy seguro pero cuando se usa 'GROUP BY', el 'ORDER BY' obligatorio 
-- tiene que hacerse al grupo de resultados. Usando una funccion de grupos o 
-- de cual quier otra manera.
select manager_id, min(salary)
from employees
group by manager_id
having manager_id is not null and min(salary) > 6000
order by salary desc;                                                           -- ERORO

select manager_id, min(salary)
from employees
group by manager_id
having manager_id is not null and min(salary) > 6000
order by min(salary) desc;                                                      -- NOT ERROR

--==========================================================================================================================================================
--==================================================================================================================================== Substitution Variable 
--==========================================================================================================================================================
-- En las variables de substitution los characters y fecha se ponen entre 
-- comillas simples

SELECT employee_id, last_name, salary, department_id
FROM employees 
WHERE employee_id = &employee_num ;

------------------------------------------------------------------------------------------------------------------ 
--                                                                          Variable de substitution con Character 

-- Si variable de substitucion se usa con character es obligatorio 
-- usar comillas simples

SELECT last_name, department_id 
FROM employees 
WHERE last_name = &last_name;                                                   -- ERROR

SELECT last_name, department_id 
FROM employees 
WHERE last_name = '&last_name';                                                 -- NOT ERROR

 

------------------------------------------------------------------------------------------------------------------ 
--                                                                              Variable de substitution con Fecha

-- Si variable de substitucion se usa con fecha es obligatorio 
-- usar comillas simples

SELECT last_name, department_id
FROM employees 
WHERE hire_date > &hire_date;                                                   -- ERROR

SELECT last_name, department_id
FROM employees 
WHERE hire_date > '&hire_date';                                                 -- NOT ERROR

------------------------------------------------------------------------------------------------------------------ 
--                                                                 Variable de substitution con palabra clave LIKE

select INITCAP(last_name) "Name", length(last_name) "Length"
from employees
where last_name like upper('&START_LETTER%');

------------------------------------------------------------------------------------------------------------------ 

SELECT employee_id, last_name, job_id, &column_name 
FROM employees 
WHERE &condition ORDER BY &order_column;

------------------------------------------------------------------------------------------------------------------ 
--                                         Variable de substitution no tiene que tener dentro de si misma espacios

select employee_id, last_name, salary, department_id
from employees
where manager_id = &Manager_id
order by &sort_from colum;                                                      -- ERROR

select employee_id, last_name, salary, department_id
from employees
where manager_id = &Manager_id
order by &sort_from_colum;                                                      -- NOT ERROR

--==========================================================================================================================================================
--================================================================================================================================= Using the DEFINE Command 
--==========================================================================================================================================================
DEFINE employee_num = 200
SELECT employee_id, last_name, salary, department_id 
FROM employees 
WHERE employee_id = &employee_num ;
UNDEFINE employee_num
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre este ejemplo

--==========================================================================================================================================================
--================================================================================================================================= Using the VERIFY Command 
--==========================================================================================================================================================
SET VERIFY ON
SELECT employee_id, last_name, salary 
FROM employees 
WHERE employee_id = &employee_num;
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre este ejemplo

--==========================================================================================================================================================
--===================================================================================================================================== Single-Row Functions
--==========================================================================================================================================================
-- 'Single-row Functions' - funccionan por cada campo de columna que 
-- se indica en parametros de funccion
-- 'Functions Group' - funccionana por columna entera que se indica 
-- en parametros de funccion

-- Si usa funccion de 'Single-Row Functions' y funccion de 'Function Group' 
-- es obligatorio poner aquel parametro que se pasa al funccion 'single-row' 
-- tambien poner en GROUP BY
select upper(last_name), max(salary) from employees;                            -- ERROR

select upper(last_name), max(salary) 
from employees 
group by last_name;                                                             -- NOT ERROR

--==========================================================================================================================================================
--====================================================================================================================================== Funcciones de Chars
--==========================================================================================================================================================

------------------------------------------------------------------------------------------------------------------ LOWER()
select 'SQL Course', lower('SQL Course') from dual;
select last_name, lower(last_name) from employees;

------------------------------------------------------------------------------------------------------------------ UPPER()
select 'SQL Course', upper('SQL Course') from dual;
select last_name, upper(last_name), hire_date, 
       upper(to_char(hire_date, 'dd month yyy')) 
from employees;

------------------------------------------------------------------------------------------------------------------ INITCAP() 
select 'SQL COUrse', initcap('SQL COUrse') from dual;
select last_name, initcap(last_name) from employees;

------------------------------------------------------------------------------------------------------------------ CONCAT()
select concat('Hello ', 'World') from dual;

SELECT CONCAT(CONCAT(last_name, '''s job category is '), job_id) "Job" 
FROM employees 
WHERE SUBSTR(job_id, 4) = 'REP';

------------------------------------------------------------------------------------------------------------------ SUBSTR()
-- SUBSTR(literal, a, b)
-- 'literal' = es string desde donde se va sacrse substring
-- 'a' = la posicion por donde empesar, incluso la posicion 'a'
-- 'b' = cantidat de los chars que qieremos sacar
select substr('HelloWorld', 0, 1) from dual;
select substr('HelloWorld', 2, 1) from dual;
select substr('HelloWorld', 2, 5) from dual;
select substr('HelloWorld', 2, 6) from dual;

-- SUBSTR(literal, a)
-- 'literal' = es string desde donde se va sacrse substring
-- 'a' = la posicion por donde empesar (incluso la posicion 'a') hasta 
-- la final de literal  
select substr('HelloWorld', 5) from dual;
select substr('HelloWorld', 10) from dual;
select substr('HelloWorld', 11) from dual;

-- substr() con campos NULL 
select last_name, substr(commission_pct, 1) from employees;
select last_name, substr(commission_pct, 1, 3) from employees;
-- Atencion
select last_name, substr(commission_pct, 5) from employees;

-- substr() con los numero negativos en parametros
select substr('​abcdefghijklmnñopqrstuvwxyz', -1, 1) from dual;
select substr('​abcdefghijklmnñopqrstuvwxyz', -5, 5) from dual;
select substr('​abcdefghijklmnñopqrstuvwxyz', -5, 4) from dual;
select substr('​abcdefghijklmnñopqrstuvwxyz', -5, 3) from dual;
-- Atencion aqui
select substr('​abcdefghijklmnñopqrstuvwxyz', -5, 7) from dual;
select substr('​abcdefghijklmnñopqrstuvwxyz', -2, 5) from dual;
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre este ejemplo

SELECT employee_id, CONCAT(first_name, last_name) "NAME",
LENGTH (last_name), INSTR(last_name, 'a') "Contains 'a'?"
FROM employees
WHERE SUBSTR(last_name, -1, 1) = 'n';

------------------------------------------------------------------------------------------------------------------ LENGTH()
-- length(literal) con string
-- 'literal' = literal donde se va contar los chars
select length('HelloWorld') from dual;
select length('Hello World') from dual;
select last_name, length(last_name) from employees;



select hire_date, length(hire_date) from employees;



select commission_pct, length(commission_pct) from employees;

------------------------------------------------------------------------------------------------------------------ INSTR()
-- instr(a, b, c, d)
-- a = literal donde buscamos concidencias
-- b = literan que estamos buscando
-- c = posicion desde donde empesar la busqueda
-- d = que concidencia qieremos encontrar la primera o segunda o tresera o ...

select instr('HelloWorld', 'W') from dual;

select instr('HelloWorld', 'B') from dual;

select instr('HelloWorld', 'Wo') from dual;

select instr('HelloWorld', 'Wq') from dual;

select instr('Hello World', 'o W') from dual;
select instr('Hello World', 'oW') from dual;

select instr('HelloWorld', 'HelloWorld') from dual;

select instr('HelloWorld', '#HelloWorld') from dual;
select instr('HelloWorld', 'HelloWorld#') from dual;

select instr('#HelloWorld', 'HelloWorld') from dual;
select instr('HelloWorld#', 'HelloWorld') from dual;

select instr('HelloWorld', 'l', 1, 1) from dual;
select instr('HelloWorld', 'l', 1, 2) from dual;
select instr('HelloWorld', 'l', 1, 3) from dual;

select instr('HelloWorld', 'l', 3, 1) from dual;
select instr('HelloWorld', 'l', 3, 2) from dual;
select instr('HelloWorld', 'l', 3, 3) from dual;

select instr('HelloWorld', 'l', 4, 1) from dual;
select instr('HelloWorld', 'l', 4, 2) from dual;
select instr('HelloWorld', 'l', 4, 3) from dual;

select instr('HelloWorld', 'l', 5, 1) from dual;
select instr('HelloWorld', 'l', 5, 2) from dual;
select instr('HelloWorld', 'l', 5, 3) from dual;

select instr('fagrhrtjy*dkfeqwhjgnhgjdg*vfgerhthshd', '*', -10, 1) from dual;
select instr('012*34567*89', '*', -4, 1) from dual;
select instr('012*34567*89', '*', -3, 1) from dual;
select instr('012*34567*89', '*', -2, 1) from dual;
select instr('012*34567*89', '*', -2, 2) from dual;
select instr('012*34567*89', '*', -1, 1) from dual;
select instr('012*34567*89', '*', -1, 2) from dual;
------------------------------------------------------------------------------------------------------------------ LPAD()
select lpad('Hello', 12, '*'), length(lpad('Hello', 12, '*')) from dual;
select last_name, lpad(last_name, 10, '*') from employees;
-- Atencion aqui, se corta last_name por ejemplo Hartstein = Hartste
select last_name, lpad(last_name, 7, '*') from employees;
select last_name, lpad(last_name, 2, '*') from employees;

------------------------------------------------------------------------------------------------------------------ RPAD()
select rpad('Hello', 12, '*'), length(rpad('Hello', 12, '*')) from dual;
select last_name, rpad(last_name, 10, '*') from employees;
-- Atencion aqui, se corta last_name por ejemplo Hartstein = Hartste
select last_name, rpad(last_name, 7, '*') from employees;
select last_name, rpad(last_name, 2, '*') from employees;

------------------------------------------------------------------------------------------------------------------ TRIMP()
-- Atencion la funccion trim() solo permite quitra primer o ultimo char de 
-- literal, si este char existe en literal
select 'HelloWorld', trim('H' FROM 'HelloWorld') from dual;
select 'HelloWorld', trim('d' FROM 'HelloWorld') from dual;

select 'qqqqABqqqqCqqq', trim('q' FROM 'qqqqABqqqqCqqq') from dual;
-- trim() por defecto elimina todos espacios en blanco por adelante de 
-- literal y por detras de 
-- literal. Espacion en medio de literal se quedan sin eliminar.
select '   AB   C    ', trim('   AB   C    ') from dual;
select '*' || '   AB   C    ' || '*', '*' || trim('   AB   C    ') || '*' 
from dual;
-- Atencion asi no funcciona sale error
select 'HelloWorld', trim('H', 'HelloWorld') from dual;  

------------------------------------------------------------------------------------------------------------------ REPLACE()
 select 'JACK and JUE', replace('JACK and JUE', 'J', 'BL') from dual;
 
 select 'JACK and JUE', replace('JACK and JUE', 'J') from dual;

------------------------------------------------------------------------------------------------------------------ TO_CHAR()
select last_name, salary, to_char(salary, '999G99D00') from employees;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre como 
-- to_char() funcciona con charcteres y con los numeros

------------------------------------------------------------------------------------------------------------------ TO_DATE() 
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre este funccion
 
--==========================================================================================================================================================
--==================================================================================================================================================== Fecha 
--==========================================================================================================================================================

-- Note: If your database is remotely located in a different time zone, the 
-- output will be the date for the operating system on which the database resides.

-- dd = dia presentada como un numero
select to_char(sysdate, 'dd') from dual;
-- day = dia de la semana presentada como: lunes, martes, miercoles, ...
select to_char(sysdate, 'day') from dual;
-- Day = dia de la semana presentada como: Lunes, Martes, Miercoles, ...
select to_char(sysdate, 'Day') from dual;
-- d = dia de la semanna presentada como: 1, 2, 3, ...
-- Atencion aqui me devuelve algo raro
select to_char(sysdate, 'd') from dual;

-- mm
-- Month
-- month
-- mon

-- yyyy
-- yy

-- rr
-- rrrr

-- Example format RR
select last_name, to_char(hire_date, 'DD-Mon-YYYY') from employees 
where hire_date < to_date('01-Jan-99', 'DD-Mon-RR'); -- 1999
select last_name, to_char(hire_date, 'DD-Mon-YYYY') from employees
where hire_date < to_date('01-Jan-99', 'DD-Mon-YY'); -- 2099

-- deferencia entre formatos de ano yy rr
select to_char(to_date('01-Jan-99', 'DD-Mon-RR'), 'dd-mm-yyyy') from dual;       -- 1999  
select to_char(to_date('01-Jan-99', 'DD-Mon-yy'), 'dd-mm-yyyy') from dual;       -- 2099

select to_char(to_date('01-Jan-50', 'DD-Mon-RR'), 'dd-mm-yyyy') from dual;       -- 1950 
select to_char(to_date('01-Jan-50', 'DD-Mon-yy'), 'dd-mm-yyyy') from dual;       -- 2050

select to_char(to_date('01-Jan-49', 'DD-Mon-RR'), 'dd-mm-yyyy') from dual;       -- 2049 
select to_char(to_date('01-Jan-49', 'DD-Mon-yy'), 'dd-mm-yyyy') from dual;       -- 2049

-- fx
select last_name, hire_date from employees 
where hire_date > to_date('01 - 01 - 2008', 'dd-mm-yyyy');                      -- not error

select last_name, hire_date from employees 
where hire_date > to_date('01 - 01 - 2008', 'fxdd-mm-yyyy');                    -- error

select last_name, hire_date from employees 
where hire_date > to_date('01-01-2008', 'fxdd-mm-yyyy');                        -- not error

select last_name, hire_date from employees 
where hire_date > to_date('01-JAN-2008', 'fxdd-mm-yyyy');                       -- error

-- fm
SELECT hire_date, to_char(hire_date, 'DD Month YYYY') HIREDATE FROM employees;
SELECT hire_date, to_char(hire_date, 'fmDD Month YYYY') HIREDATE FROM employees;
SELECT hire_date, to_char(hire_date, 'DD MM YYYY') HIREDATE FROM employees;
SELECT hire_date, to_char(hire_date, 'fmDD MM YYYY') HIREDATE FROM employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                            spht

-- Ddspth
SELECT hire_date, 
       to_char(hire_date, 'Ddspth "of" Month YYYY HH:MI:SS AM') HIREDATE 
FROM employees;

-- dDspth
SELECT hire_date, 
       to_char(hire_date, 'dDspth "of" Month YYYY HH:MI:SS AM') HIREDATE 
FROM employees;                                                                 -- No funcciona

-- Monthspth    
SELECT hire_date, 
       to_char(hire_date, 'dd "of" Monthspth YYYY HH:MI:SS AM') HIREDATE 
FROM employees;                                                                 -- ERROR

-- Mmspth     
SELECT hire_date, 
       to_char(hire_date, 'dd "of" Mmspth YYYY HH:MI:SS AM') HIREDATE 
FROM employees;                                                                 -- NOT ERROR

-- YYYYspth 
SELECT hire_date, 
       to_char(hire_date, 'Dd"of" Month YYYYsppth HH:MI:SS AM') HIREDATE 
FROM employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                              sp

-- Ddsp
SELECT hire_date, 
       to_char(hire_date, 'Ddsp "of" Month YYYY HH:MI:SS AM') HIREDATE 
FROM employees;

-- dDsp --> No funcciona
SELECT hire_date, 
       to_char(hire_date, 'dDsp "of" Month YYYY HH:MI:SS AM') HIREDATE 
FROM employees;

-- Monthsp   
SELECT hire_date, 
       to_char(hire_date, 'dd "of" Monthsp YYYY HH:MI:SS AM') HIREDATE 
FROM employees;                                                                 --  ERROR

-- Mmsp     
SELECT hire_date, 
       to_char(hire_date, 'dd "of" Mmsp YYYY HH:MI:SS AM') HIREDATE 
FROM employees;                                                                 -- NOT ERROR

-- YYYYsp 
SELECT hire_date, 
       to_char(hire_date, 'Dd"of" Month YYYYsp HH:MI:SS AM') HIREDATE 
FROM employees;

------------------------------------------------------------------------------------------------------------------ 

-- fecha de servidor base datos
select sysdate from dual; 

-- Con estos dos ajustes se puede cambiar el formato 
-- de fecha: nls_lang, nls_date_format . 
-- La configuracion nls_date_format tiene mas potncia que nls_lang
-- Cambiar formato de fecha de la session;
alter session set nls_date_format = 'dd-mm-yyyy hh24:mi:ss' 

-- Es la fecha de mi conneccion (fecha de mi portatil con cual estou entrando 
-- al sevidor de base datos)
select CURRENT_DATE from dual;   

SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL;

SELECT SESSIONTIMEZONE, CURRENT_TIMESTAMP FROM DUAL;

------------------------------------------------------------------------------------------------------------------ 

select to_char(sysdate, 'DD/MM/YYYY hh:mi:ss') from dual;
select to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss') from dual;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                   Operaciones - + * / con fecha

select sysdate, to_char(sysdate + 7, 'DD-Mon-YYYY hh24:mi:ss') from dual;
select sysdate, to_char(sysdate - 7, 'DD-Mon-YYYY hh24:mi:ss') from dual;

-- Error Multiplication y division no se permiten con fechas
select sysdate, to_char(sysdate * 2, 'DD-Mon-YYYY hh24:mi:ss') from dual;       -- Error 
select sysdate, to_char(sysdate / 2, 'DD-Mon-YYYY hh24:mi:ss') from dual;       -- Error 

-- Menos dies horas desde la fecha actual
select to_char(sysdate, 'DD-Mon-YYYY hh24:mi:ss') , 
       to_char(sysdate - (10/24), 'DD-Mon-YYYY hh24:mi:ss') 
from dual;

-- Menos dies minutos desde la fecha actual
select to_char(sysdate, 'DD-Mon-YYYY hh24:mi:ss') , 
       to_char(sysdate - (10/24/60), 'DD-Mon-YYYY hh24:mi:ss') 
from dual;

-- Menos dies segundos desde la fecha actual
select to_char(sysdate, 'DD-Mon-YYYY hh24:mi:ss') , 
       to_char(sysdate - (10/24/60/60), 'DD-Mon-YYYY hh24:mi:ss') 
from dual;

select round(sysdate - hire_date), trunc(sysdate - hire_date) from employees;

-- Cuantas semanas cada empleado he trabajado en impresa
select last_name, round((sysdate - hire_date) / 7), (sysdate - hire_date) / 7 
from employees 
order by 2 desc;

------------------------------------------------------------------------------------------------------------------ 

select to_char(sysdate, 'hh:mi:ss') Time from dual;

select to_char(sysdate, 'hh:mi:ss " Hora de descanso"') Time from dual;

select to_char(sysdate, 'day/month/year') from dual;

SELECT last_name, hire_date, 
       to_char(hire_date, 'fmddspth "of" Month YYYY fmHH:MI:SS AM') HIREDATE 
FROM employees;

SELECT last_name, hire_date, 
       to_char(hire_date, 'fmdd "of" MMspth YYYY fmHH:MI:SS AM') HIREDATE 
FROM employees;

SELECT last_name, hire_date, 
       to_char(hire_date, 'fmdd "of" Month YYYYspth fmHH:MI:SS AM') HIREDATE 
FROM employees;

-- dd Dd DD mm Mm MM yyy Yyy YYy YYY

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                 Formatos de ano
select to_date('01-JAN-1999', 'dd mm yyyy') from dual;
select to_date('01-JAN-99', 'dd mm yy') from dual;
select to_date('01-JAN-99', 'dd mm rr') from dual;
select to_date('01-JAN-1999', 'dd mm rrrr') from dual;

------------------------------------------------------------------------------------------------------------------ 
--                                                                    Operacones <, <=, >, >=, =, <>, =! con fecha

SELECT last_name, hire_date 
FROM employees 
WHERE hire_date < '01-FEB-2008';

select last_name, hire_date 
from employees 
where hire_date > '01-JAN-1999';

select last_name, hire_date 
from employees 
where hire_date > '01-JAN-99';

select last_name, hire_date
from employees
where to_char(hire_date, 'yyyy') = '2006';

------------------------------------------------------------------------------------------------------------------ 

-- Distinct 
select distinct hire_date from employees;

------------------------------------------------------------------------------------------------------------------ 


--==========================================================================================================================================================
--====================================================================================================================================== Funcciones de Fecha 
--==========================================================================================================================================================

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                       TO_CHAR()

select to_char(sysdate, 'd-dy-day') from dual;

SELECT last_name, hire_date, 
       to_char(hire_date, 'DD Month YYYY') HIREDATE 
FROM employees;

SELECT last_name, hire_date, 
       to_char(hire_date, 'YYYY') HIREDATE 
FROM employees;

select to_char(sysdate, 'hh:mi:ss') Time from dual;

-- Error texto se pone en comillas dobles
select to_char(sysdate, 'hh:mi:ss Hora de descanso') "Time" from dual;          -- Error

-- Texto enter comillas dobles
select to_char(sysdate, 'hh:mi:ss " Hora de descanso"') "Time" from dual;       -- NOT ERROR

select to_char(sysdate, 'day/month/year') from dual;

select to_char(sysdate, 'dd-month-yyyy', 'nls_date_language=american') from dual;
select to_char(sysdate, 'dd-month-yyyy', 'nls_date_language=spanish') from dual;
select to_char(sysdate, 'dd-month-yyyy', 'nls_date_language=ukrainian') from dual;
select to_char(sysdate, 'dd-month-yyyy', 'nls_date_language=german') from dual;
select to_char(sysdate, 'dd-month-yyyy', 'nls_date_language=french') from dual;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                        to_date()

-- Si hacer calculo con esta manera sale Error por no concidir formato de fecha
select last_name, hire_date 
from employees 
where hire_date > '10-03-1999'; 

-- Funccion to_date() nos auda darle fecha con culaquier formato pero tenemos 
-- pasar al los parametros el formato de la fecha que pide base de datos
select last_name, hire_date 
from employees 
where hire_date > to_date('10-03-1999', 'dd-mm-yyyy');

-- no me funcciona 
select last_name, hire_date 
from employees 
where hire_date > to_date('10-03-1999', 'dd-mon-yyyy', 'nls_date_language=american');

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                 months_between()

-- Cuantos meses cada empleado he trabajado en impresa
select last_name, months_between(sysdate, hire_date) 
from employees 
order by 2 desc;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                     add_months()

select sysdate, add_months(sysdate, 3) from dual;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                       next_day()

-- jueves que viene
select next_day(sysdate, 'thu') from dual;
-- jueves pasado
select next_day(sysdate, 'thu') from dual;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                       last_day()

-- devuelve ultimo dia de mes
select last_day(sysdate) from dual;
select last_day(sysdate + 2) from dual;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                         round()

-- round Year
select to_char(round(sysdate, 'Year'), 'dd-mm-yyyy hh24:mi:ss'), 
       to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss') 
from dual;

-- round Month
select to_char(round(sysdate, 'Month'), 'dd-mm-yyyy hh24:mi:ss'), 
       to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss') 
from dual;

-- round day
select to_char(round(sysdate, 'DD'), 'dd-mm-yyyy hh24:mi:ss'), 
       to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss')  
from dual;

-- Atencion aquei algo esta pasando raro, 
select to_char(round(sysdate, 'Day'), 'dd-mm-yyyy hh24:mi:ss'), 
       to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss') 
from dual;                                                                      -- Atencion 

-- round hours
select to_char(round(sysdate, 'HH'), 'dd-mm-yyyy hh:mi:ss'), 
       to_char(sysdate, 'dd-mm-yyyy hh:mi:ss') 
from dual;

-- round minutes
select to_char(round(sysdate, 'MI'), 'dd-mm-yyyy hh:mi:ss'), 
      to_char(sysdate, 'dd-mm-yyyy hh:mi:ss') 
from dual;

-- round segundos
-- Error, no permite usar funccion rounda con segundos
select to_char(round(sysdate, 'ss'), 'dd-mm-yyyy hh:mi:ss'), 
       to_char(sysdate, 'dd-mm-yyyy hh:mi:ss') 
from dual;                                                                      -- Error 

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                          trunc()


------------------------------------------------------------------------------------------------------------------ 
--                                                                                              substr() con fecha

select last_name, substr(hire_date, 1, 6) from employees;
select last_name, substr(hire_date, 4) from employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                              count() con fecha

select count(distinct hire_date)
from employees
where hire_date = '01-FEB-2008';

select count('2008')
from employees;

--==========================================================================================================================================================
--================================================================================================================================================== Numeros 
--==========================================================================================================================================================
-- nls_lang=american_america   coneste ajuste se puede cambiar el 
-- region de base datos

-- Distinct 
select distinct salary from employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                              fm

select salary, to_char(salary, 'fm$99,999.00') "Dream Salaries"
from employees;

select salary, to_char(salary, '$99,999.00') "Dream Salaries"
from employees;

--==========================================================================================================================================================
--==================================================================================================================================== Funcciones de Numeros 
--==========================================================================================================================================================

-- You can use the AVG, SUM, MIN, and MAX functions against the columns that 
-- can store numeric data.

-- 'nls_numeric_characters = '',.'''
select to_char(round((salary / 7), 2), '99G999D99', 'nls_numeric_characters = '',.''') "Formated Salary" 
from employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                       TO_CHAR()

-- G = 
-- D = 
select last_name, salary, to_char(salary, '999G99D00') from employees;

-- L = Con la letra 'L' es puede poner el simbolo de dinero. Simbolo de dinero 
-- depende de los ajuctes de ...
select last_name, salary, to_char(salary, '999G99D00L') from employees;

-- $ = Con simbolo '$' es puede poner el simbolo de dinero Dolar.
select last_name, salary, to_char(salary, '999G99D00$') from employees;

-- en comando cofig todas comillas son simples(no dobles)
select last_name, salary, 
      to_char(salary, '999G99D00$', 'nls_numeric_characters = ''. ''') 
from employees; 

select last_name, salary, 
       to_char(salary, '999G99D00$', 'nls_numeric_characters = '' .''') 
from employees;

select last_name, salary, 
       to_char(salary, '999G99D00$', 'nls_numeric_characters = ''.#''') 
from employees;

select last_name, salary, 
       to_char(salary, '999G99D00$', 'nls_numeric_characters = ''_*''') 
from employees;

select last_name, salary, to_char(salary, '999,99.00$') from employees;

-- Atencion Error  ?????????
select last_name, salary, to_char(salary, '999*99_00$') from employees;

select salary, to_char(salary, 'fm$99,999.00') "Dream Salaries"
from employees;

select salary, to_char(salary, '$99,999.00') "Dream Salaries"
from employees;

------------------------------------------------------------------------------------------------------------------ to_number()
select to_number('34') from dual;

-- Fecha no se puede convertir en numero
select to_number(sysdate) from dual;

select last_name, salary from employees 
where salary > to_number('10 000.00', '999G999D00');

------------------------------------------------------------------------------------------------------------------ to_date()


------------------------------------------------------------------------------------------------------------------ ROUND()
SELECT ROUND(45.9235,2), ROUND(45.923,0), ROUND(45.923,-1), ROUND(445.923,-2), 
ROUND(455.923,-2),ROUND(455.923,-3), ROUND(45.9235), ROUND(45) FROM DUAL;

------------------------------------------------------------------------------------------------------------------ TRUNC()
SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923, 0), TRUNC(45.923,-1), 
       TRUNC(450.923,-2), TRUNC(45)  
FROM DUAL;

select salary, trunc(salary, -2) from employees;

------------------------------------------------------------------------------------------------------------------ CEIL()
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre ceil()

------------------------------------------------------------------------------------------------------------------ FLOOR()
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre floor()

------------------------------------------------------------------------------------------------------------------ MOD()
SELECT employee_id as "Even Numbers", last_name 
FROM employees 
WHERE MOD(employee_id,2) = 0;

------------------------------------------------------------------------------------------------------------------ substr() con numeros
select substr(1234567, 1, 5) from dual;
select last_name, substr(salary, 1, 3) from employees;

------------------------------------------------------------------------------------------------------------------ length() con numeros
-- length(literal) con numeros
-- 'literal' = literal donde se va contar los numeros
select length(1234567) from dual;
select salary, length(salary) from employees;

--==========================================================================================================================================================
--========================================================================================================================================= Generic function 
--==========================================================================================================================================================

------------------------------------------------------------------------------------------------------------------ NVL()
select last_name, commission_pct, nvl(commission_pct, 0) from employees;

-- Atencion Error. El valor del campo commission_pct es numerico y nosotros 
-- queremos poner en campo commission_pct valor character.
select last_name, commission_pct, nvl(commission_pct, 'no comm') from employees; -- ERROR

-- Error de ariba se puede resolver por esta solucion, si es necesario.
select last_name, commission_pct, nvl(to_char(commission_pct), 'no comm') 
from employees;

select last_name, commission_pct, nvl(to_char(commission_pct, '0.99'), 'no comm') 
from employees;

select first_name, (salary * (1 + nvl(commission_pct, 0))) * 12 from employees;

--------------------------------------------------------------------------------

-- La ERROR sale aqui porque el campo 'commission_pct' es numerico y value por 
-- defecto('No Commission') que estamos dando es character.
select last_name, nvl(commission_pct, 'No Commission') "COMM"
from employees;                                                                 -- ERROR
 
 -- Para resolver esa ERROR tenecom que convetir value 'commission_pct' 
-- al character
select last_name, nvl(to_char(commission_pct), 'No Commission') "COMM"
from employees;                                                                 -- NOT ERROR

------------------------------------------------------------------------------------------------------------------ NVL2()
select last_name, salary, commission_pct, 
       nvl2(commission_pct, 
             round((((salary/100)*commission_pct) + salary)), salary ) 
from employees;
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre esta funccion

select commission_pct, nvl2(commission_pct, 'commission * salary', 'salary') 
from employees;

select commission_pct, nvl2(commission_pct, (((salary/100)*commission_pct) + salary), salary) 
from employees;

------------------------------------------------------------------------------------------------------------------ nullif()
-- nullif(a, b)
-- a = primer value
-- b = segundo value
-- si value 'a' y value 'b' son iguales funccion devulve null, si values no 
-- son iguales funccion devuelve value 'a'
select first_name, length(first_name) "expr1", 
       last_name, length(last_name) "expr1", 
       nullif(length(first_name), length(last_name)) "result" 
from employees;

------------------------------------------------------------------------------------------------------------------ coalesce
-- coalesce(a, b, c)
-- a = primer value
-- b = segundo value
-- c = value que se devuelve si values 'a' y 'b' son ambos nullos
-- coalesce devuelve value 'c' si value 'a' y value 'b' son nullos
-- coalesce devuelve value 'a' si value 'a' no es igual al null y 
-- value 'b' es nullo
-- coalesce devuelve value 'b' si value 'b' no es igual al null y 
-- value 'a' es nullo
-- coalesce devuelve value 'b' si value 'b' no es igual al null y 
-- value 'a' no es igual a nullo.
select last_name, employee_id, manager_id, commission_pct, 
       coalesce(to_char(commission_pct), 
                to_char(manager_id), 'No commission and no manager') 
from employees;

--==========================================================================================================================================================
--======================================================================================================================================== Nesting Functions
--==========================================================================================================================================================

SELECT last_name, UPPER(CONCAT(SUBSTR (LAST_NAME, 1, 8), '_US')) 
FROM employees 
WHERE department_id = 60;


--==========================================================================================================================================================
--========================================================================================================================================== CASE Expression
--==========================================================================================================================================================
select last_name, department_id, salary, 
  case department_id when 110 then 'Bestia'
                     when 90 then 'Myu buenos'
                     when 20 then 'Buenos'
  else 'Mantas' end "Titulos"
from employees;
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar mas informacion sobre esta funccion

-- condition puede ser cualquiera 
select last_name, job_id, salary, 
  case job_id when 'IT_PROG' then 1.10 * salary
              when 'ST_CLERK' then 1.15 * salary
              when 'SA_REP' then 1.20 * salary
  else salary end "REVISE SALARY"
from employees;

-- mismo resultado
select last_name, job_id, salary, 
  case when job_id = 'IT_PROG' then 1.10 * salary
       when job_id = 'ST_CLERK' then 1.15 * salary
       when job_id = 'SA_REP' then 1.20 * salary
  else salary end "REVISE SALARY"
from employees;

------------------------------------------------------------------------------------------------------------------ 

select count(distinct hire_date), 
       sum(case to_char(hire_date, 'yyyy') when '2005' then 1 else 0 end) "2005",
       sum(case to_char(hire_date, 'yyyy') when '2006' then 1 else 0 end) "2006",
       sum(case to_char(hire_date, 'yyyy') when '2007' then 1 else 0 end) "2007",
       sum(case to_char(hire_date, 'yyyy') when '2008' then 1 else 0 end) "2008"
from employees;

select job_id, 
       sum(case department_id when 20 then salary else 0 end) "Dept 20",
       sum(case department_id when 50 then salary else 0 end) "Dept 50",
       sum(case department_id when 80 then salary else 0 end) "Dept 80",
       sum(case department_id when 90 then salary else 0 end) "Dept 90",
       sum(salary) "Total"
from employees
group by job_id;

--==========================================================================================================================================================
--======================================================================================================================================== DECODE Expression
--==========================================================================================================================================================
-- decode sravnevaet tolko na ravenstvo.
-- decode compara solo de igualidad, no se permite poner 
-- expressiones de <, <=, >, >= ...
select job_id, decode(job_id,
            'IT_PROG', 'Programador', 
            'AD_PRES', 'Presidente', 
            'NOT DEFINE') 
from employees; 

select last_name, job_id, salary, 
     decode(job_id, 'IT_PROG', 1.10 * salary,
                    'ST_CLERK', 1.15 * salary,
                    'SA_REP', 1.20 * salary,
                    salary) 
    "REVISE SALARY"
from employees;

select last_name, salary,trunc(salary / 2000, 0), 
     decode(trunc(salary / 2000, 0),
                    0, 0.00,
                    1, 0.09,
                    2, 0.20,
                    3, 0.30,
                    4, 0.40,
                    5, 0.42,
                    6, 0.44,
                    0.45) 
    "TAX_RATE"
from employees;

------------------------------------------------------------------------------------------------------------------ 

select job_id, 
       sum(decode(department_id, 20, salary)) "Dept 20",
       sum(decode(department_id, 50, salary)) "Dept 50",
       sum(decode(department_id, 80, salary)) "Dept 80",
       sum(decode(department_id, 90, salary)) "Dept 90",
       sum(salary) "Total"
from employees
group by job_id;

select count(distinct hire_date), 
       sum(decode(to_char(hire_date, 'yyyy'), '2005', 1, 0)) "2005",
       sum(decode(to_char(hire_date, 'yyyy'), '2006', 1, 0)) "2006",
       sum(decode(to_char(hire_date, 'yyyy'), '2007', 1, 0)) "2007",
       sum(decode(to_char(hire_date, 'yyyy'), '2008', 1, 0)) "2008"
from employees;

--==========================================================================================================================================================
--================================================================================================================================================= GROUP BY 
--==========================================================================================================================================================

-- You can use the GROUP BY clause to divide the rows in a table into groups. 
-- You can then use the group functions to return summary information for each
-- group.

-- Guidelines
-- • If you include a group function in a SELECT clause, you cannot select 
--   individual column as well, unless the individual column appears in the 
--   GROUP BY clause. You receive an error message if you fail to include the 
--   column list in the GROUP BY clause.
-- • Using a WHERE clause, you can exclude rows before dividing them into groups.
-- • You can substitute column with an expression in the SELECT statement.
-- • You must include the columns in the GROUP BY clause.
-- • You cannot use a column alias in the GROUP BY clause.

-- Place the HAVING and GROUP BY clauses after the WHERE clause in a statement. 
-- The order of the GROUP BY and HAVING clauses following the WHERE clause is not 
-- important. You can have either the GROUP BY clause or the HAVING clause first 
-- as long as they follow the WHERE clause. Place the ORDER BY clause at the end.

-- When using the GROUP BY clause, make sure that all columns in the SELECT 
-- list that are not group functions are included in the GROUP BY clause.

-- Note: To order the query results in ascending or descending order, include 
-- the ORDER BY clause in the query.

-- You can substitute column with an expression in the SELECT statement.

------------------------------------------------------------------------------------------------------------------ 
--                                                      The GROUP BY column does not have to be in the SELECT list

-- Columna que se indica en GROUP BY, puede no estar indicada en SELECT
select avg(salary) from employees group by department_id;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                      GROUP BY y Group Functions

-- You cannot use the WHERE clause to restrict groups.
SELECT department_id, AVG(salary)
FROM employees
WHERE AVG(salary) > 8000
GROUP BY department_id;                                                         -- ERROR

-- You use the HAVING clause to restrict groups.
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 8000;                                                         

-- Si usamos en select una funccion de agrupacion o varial funciones de 
-- agrupacion no es obligatorio poner GROUP BY
select sum(salary) from employees;
select max(salary), sum(salary) from employees;

-- You cannot use group functions in the WHERE clause.

-- Campo salary no es obligatorio poner en GROUP BY por rason que 
-- campo salary se usa con funcion de agrupacion.
select last_name, department_id, sum(salary) 
from employees 
group by department_id, last_name;

select department_id, sum(salary) from employees group by department_id;

------------------------------------------------------------------------------------------------------------------

-- If you include a group function in a SELECT clause, you cannot select 
-- individual column as well, unless the individual column appears in the 
-- GROUP BY clause. You receive an error message if you fail to include the 
-- column list in the GROUP BY clause.
select department_id, sum(salary) from employees;                               -- ERROR

-- NOT ERROR
select department_id, sum(salary) from employees group by department_id;

-- ERROR.Si usamos una columna y una funccion de agrupacion tenemos que indicar 
-- con que campos nos vamos agrupar, y los estos campos que se encuentran en 
-- select que no esten en funcciones de agrupacion
select last_name, department_id, sum(salary) from employees;                    -- ERROR

-- NOT ERROR
select last_name, department_id, sum(salary) 
from employees
group by department_id, last_name;    

------------------------------------------------------------------------------------------------------------------
--                                                      The GROUP BY column does not have to be in the SELECT list

SELECT AVG(salary)
FROM employees
GROUP BY department_id ;

------------------------------------------------------------------------------------------------------------------ 
--                                                        All the columns in the SELECT list that are not in group 
--                                                        functions must be in the GROUP BY clause.

-- Any column or expression in the SELECT list that is not an aggregate function 
-- must be in the GROUP BY clause:

-- You must include the columns in the GROUP BY clause.

-- A GROUP BY clause must be added to count the last names for 
-- each department_id.
SELECT department_id, COUNT(last_name) FROM employees;                          -- ERROR

-- Either add job_id in the GROUP BY or remove the job_id column 
-- from the SELECT list.
SELECT department_id, job_id, COUNT(last_name)
FROM employees
GROUP BY department_id;                                                         -- ERROR

-- Atencion ERROR. Todos campos que se encuentran en select y 
-- cuales no se usan para agrupacion, es obligatorio poner en GROUP BY
select last_name, department_id
from employees 
group by department_id;                                                         -- ERROR

-- NOT ERROR
select last_name, department_id
from employees 
group by department_id, last_name;                                              -- NOT ERROR

------------------------------------------------------------------------------------------------------------------
--                                        Usar WHERE antes de GROUP BY para filtrar resultados antes de agrupacion

-- Using a WHERE clause, you can exclude rows before dividing them into groups.
select department_id 
from employees
where hire_date > '19-JAN-2008'
group by department_id;

select department_id 
from employees
group by department_id;

------------------------------------------------------------------------------------------------------------------
--                                                                                             GROUP BY y ORDER BY

select department_id, job_id, sum(salary) 
from employees
group by department_id, job_id 
order by 1;

-- You can also use the group function in the ORDER BY clause:
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary);

------------------------------------------------------------------------------------------------------------------
--                                                                           No se permite usar alias con GROUP BY

-- You cannot use a column alias in the GROUP BY clause.
-- Atencion. No se permite agrupar por alias, hay que usar nombre de columna
select department_id "D", sum(salary) from employees group by D;                -- ERROR
select department_id "D", sum(salary) from employees group by department_id;

------------------------------------------------------------------------------------------------------------------
--                                                                       'Single-Row Functions' y 'Function Group' 

-- Si usa funccion de 'Single-Row Functions' y funccion de 'Function Group' 
-- es obligatorio poner aquel parametro 
-- que se pasa al funccion 'single-row' tambien poner en GROUP BY
select upper(last_name), max(salary) from employees;                            -- ERROR
select upper(last_name), max(salary) from employees group by last_name;         -- NOT ERROR

------------------------------------------------------------------------------------------------------------------
--                                                                                Grouping by More Than One Column

-- Usar GROUP BY con varios columnas
SELECT department_id, job_id, sum(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY job_id;id;

------------------------------------------------------------------------------------------------------------------
--                                                                   Using the GROUP BY Clause on Multiple Columns

SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id;

-- Note: The SUM function is applied to the salary column for all job IDs in the
-- result set in each DEPARTMENT_ID group. Also, note that the SA_REP row is 
-- not returned. The DEPARTMENT_ID for this row is NULL and, therefore, does 
-- not meet the WHERE condition.

--==========================================================================================================================================================
--=================================================================================================================================================== HAVING 
--==========================================================================================================================================================
-- The Oracle server performs the following steps when you use the HAVING clause:
--      1. Rows are grouped.
--      2. The group function is applied to the group.
--      3. The groups that match the criteria in the HAVING clause are displayed.

-- Note: The WHERE clause restricts rows, whereas the HAVING clause restricts groups.

-- Place the HAVING and GROUP BY clauses after the WHERE clause in a statement. 
-- The order of the GROUP BY and HAVING clauses following the WHERE clause is not 
-- important. You can have either the GROUP BY clause or the HAVING clause first 
-- as long as they follow the WHERE clause. Place the ORDER BY clause at the end.

------------------------------------------------------------------------------------------------------------------
--                                                                                         Using the HAVING Clause

select department_id, sum(salary) 
from employees 
group by department_id;

select department_id, sum(salary) 
from employees 
group by department_id 
having sum(salary) > 10000;

select department_id, max(salary) 
from employees 
group by department_id 
having max(salary) > 10000;

SELECT job_id, SUM(salary) PAYROLL
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY SUM(salary);

------------------------------------------------------------------------------------------------------------------

-- ATENCION ERROR.
select department_id, max(salary) 
from employees 
group by department_id 
having max(salary) > 10000 
order by salary;                                                                -- ATENCION ERROR

-- Aqui no tiene error
select department_id, max(salary) 
from employees 
group by department_id 
having max(salary) > 10000 
order by max(salary);

select department_id, max(salary) 
from employees 
group by department_id 
having max(salary) > 10000 
order by department_id;

-- Query de abajo esta incorrecto!!! Funcciona extrano
select department_id, max(salary) 
from employees 
group by department_id, salary 
having max(salary) > 10000 
order by salary;                                                                --ATENCION

-- Este example funccion bien, pero para performance este example malo.
select department_id, sum(salary) 
from employees 
group by department_id 
having department_id <> 50;

-- Mejor hacer de esta manera
select department_id, sum(salary) 
from employees 
where department_id <> 50 
group by department_id;

-- Queris con mismos resultados
select job_id, sum(salary) PAYROLL 
from employees 
where job_id not like '%REP%' 
group by job_id 
having sum(salary) > 13000 
order by sum(salary);

select job_id, sum(salary) PAYROLL 
from employees 
where job_id not like '%REP%' 
group by job_id 
having sum(salary) > 13000 
order by PAYROLL;

select job_id, sum(salary) PAYROLL 
from employees 
where job_id not like '%REP%' 
group by job_id 
having sum(salary) > 13000 
order by 2;

--==========================================================================================================================================================
--========================================================================================================================================== Functions Group
--==========================================================================================================================================================

-- Guidelines for using the group functions:
--• DISTINCT makes the function consider only nonduplicate values; ALL makes it
--  consider every value, including duplicates. The default is ALL and, 
--  therefore, does not need to be specified.
--• The data types for the functions with an expr argument may be CHAR, 
--  VARCHAR2,NUMBER, or DATE.
--• All group functions ignore null values. To substitute a value for null 
--  values, use the NVL, NVL2, COALESCE, CASE, or DECODE functions.

-- Group functions operate on sets of rows to give one result per group.

-- Unlike single-row functions, group functions operate on sets of rows to give
-- one result per group. These sets may comprise the entire table or the table 
-- that is split into groups.

-- All group functions ignore null values in the column.

-- You can use the AVG, SUM, MIN, and MAX functions against the columns that 
-- can store numeric data.


-- 'Single-row Functions' - funccionan por cada campo de columna que se 
-- indica en parametros de funccion

-- 'Functions Group' - funccionana por columna entera que se indica en 
-- parametros de funccion

-- Se recomienda (para entender todas cosas) antes de estudiar las funciones 
-- de agrupacion hay que estudiar GROUP BY

-- Note: The AVG, SUM, VARIANCE, and STDDEV functions can be used only with 
-- numeric data types. MAX and MIN cannot be used with LOB or LONG data types.

-- You can also use the group function in the ORDER BY clause:
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary);

------------------------------------------------------------------------------------------------------------------

-- Si usamos en select una funccion de agrupacion o varias funciones de 
-- agrupacion no es obligatorio poner GROUP BY
select sum(salary) from employees;

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees;

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary), count(employee_id) 
FROM employees 
where job_id like '%REP%';

-- Atencion ERROR. Si en select se usa una columna y alguna funccion de 
-- agrupacion, es obligatorio usar GROUP BY
select last_name, max(salary) from employees;                                   -- Atencion ERROR

-- Aqui ya no nos sale ERROR
select last_name, max(salary) from employees group by salary, last_name;        -- NOT ERROR

-- Si usa funccion de 'Single-Row Functions' y funccion de 'Function Group' 
-- es obligatorio poner aquel parametro 
-- Que se pasa al funccion 'single-row' tambien poner en GROUP BY
select upper(last_name), max(salary) from employees;                            -- ERROR
select upper(last_name), max(salary) from employees group by last_name;         -- NOT ERROR

-- No se permite usar 'FUNCTIONS GROUP' en causula 'WHERE'. Example abajo
select department_id, avg(salary) 
from employees 
where avg(salaty) > 8000 
group by department_id;

------------------------------------------------------------------------------------------------------------------
--                                                                                 Group Functions and Null Values

-- All group functions ignore null values in the column.
-- However, the NVL function forces group functions to include null values.

-- Group functions ignore null values in the column:
SELECT AVG(commission_pct)
FROM employees;

-- The NVL function forces group functions to include null values:
SELECT AVG(NVL(commission_pct, 0))
FROM employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                             AVG

-- Average value of 'n' elemnts, ignoring null values

-- Cuando se calcula avg, los campos que estan rellnos de nullos no se cuntan

-- You can use the AVG, SUM, MIN, and MAX functions against the columns that 
-- can store numeric data.

select avg(salary) from employees;

-- ERROR no permite value fecha
select avg(hire_date) from employees;                                           -- ERROR  

-- ERROR no permite value character
select avg(last_name) from employees;                                           -- ERROR  

-- AVG entre aquellas personas que tiene commission
select avg(commission_pct) from employees;

-- AVG entre todas personas de tabla, incluso aquella personas que no 
-- tienen puesta la commission
select avg(nvl(commission_pct,0)) from employees;

-- otro exemplo mas
select avg(commission_pct), 
       sum(commission_pct)/count(commission_pct), 
       sum(commission_pct)/count(*)  
from employees; 

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                           COUNT

-- Number of rows, where expr evaluates to something other than null (count 
-- all selected rows using *, including duplicates and rows with nulls)

-- In contrast, COUNT(expr) returns the number of non-null values that are in 
-- the column identified by expr.

-- COUNT(DISTINCT expr) returns the number of unique, non-null values that are 
-- in the column identified by expr.

-- Devuelve cantidad de las filas(registros) en tabla
select count(*) from employees;

select count(*) from employees where department_id = 50;

select count(employee_id) from employees;

select count(hire_date) from employees;
select count(last_name) from employees;

-- ATENCION. Los campos nulos count() no cuenta
select count(commission_pct) from employees;

-- Para poder contar todos campos incluso nullos se puede hacer con esta manera
-- Rellenando campos nulos con 'zero'
select count(nvl(commission_pct, 0)) from employees;

-- Distinct
select count(distinct department_id) from employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                             MAX

-- Maximum value of expr, ignoring null values

-- You can use the AVG, SUM, MIN, and MAX functions against the columns that 
-- can store numeric data.

-- You can use MIN and MAX for numeric, character, and date data types.

-- You can use the MAX and MIN functions for numeric, character, and date data types.

-- MAX and MIN cannot be used with LOB or LONG data types.

select max(salary) from employees;
select max(hire_date) from employees;
select max(last_name) from employees;

-- ATENCION. Los campos nulos MAX() no cuenta
select max(commission_pct) from employees;                                      -- ATENCION

-- Esto tiene poca importancia con funccion MAX(), para poder sacar todos campos 
-- de esta columna 
-- incluso campos nullos se puede hacer con esta manera
select max(nvl(commission_pct, 0)) from employees;

------------------------------------------------------------------------------------------------------------------ 
--                                                                                                             MIN

-- Minimum value of expr, ignoring null values

-- You can use the AVG, SUM, MIN, and MAX functions against the columns that 
-- can store numeric data.

-- You can use MIN and MAX for numeric, character, and date data types.

-- You can use the MAX and MIN functions for numeric, character, and date data types.

-- MAX and MIN cannot be used with LOB or LONG data types.

select min(salary) from employees;
select min(hire_date) from employees;
select min(last_name) from employees;

-- ATENCION. Los campos nulos MIN() no cuenta
select min(commission_pct) from employees;                                      -- ATENCION

-- ATENCION CON ESTA INFORMACION, PUEDE SER FALSA
-- Para poder resolver problema de campos nullos se puede resolve de 
-- esta manera. Pero es mucho depende de la tarea: 
--     1) Sacar minima comision de todos empleados que tiene comision puesta
--     2) Sacar minima comision de todos empleados que tiene comision puesta, 
--        y de aquellos que no tienen la comision puesta(Esta pregunta es 
--        muy logica commission = 0)
select min(nvl(commission_pct, 0)) from employees;

------------------------------------------------------------------------------------------------------------------ SUM

-- Sum values of n, ignoring null values

-- You can use the AVG, SUM, MIN, and MAX functions against the columns that 
-- can store numeric data.

select sum(salary) from employees;

select sum(last_name) from employees;   -- ERROR no permite value character
select sum(hire_date) from employees;   -- ERROR no permite value fecha

select sum(salary) from employees where department_id = 50;

select sum(commission_pct) from employees;

------------------------------------------------------------------------------------------------------------------ LISTAGG

-- Orders data within each group specified in the ORDER BY clause and then 
-- concatenates the values of the measure column


------------------------------------------------------------------------------------------------------------------ STDDEV

-- Standard deviation of n, ignoring null values

------------------------------------------------------------------------------------------------------------------ VARIANCE

-- Variance of n, ignoring null values


--==========================================================================================================================================================
--================================================================================================================================== Nesting Group Functions
--==========================================================================================================================================================
-- Group functions can be nested to a depth of two functions.

-- Display the maximum average salary
select max(avg(salary)) 
from employees 
group by department_id;

select avg(salary) 
from employees 
group by department_id;

------------------------------------------------------------------------------------------------------------------
--                                                       Group functions can be nested to a depth of two functions

select max(avg(salary)) 
from employees 
group by department_id; 

-- Cuidado aqui para no equivocarse en esta situacion que ocurre en 
-- ejemplo de abajo. No son 'Nesting Group Functions'.
-- Cuando una de las funcciones es 'Single Row Function' el conjunto de estas
-- funcciones no es 'Nesting Group Functions'. 
-- En este tipo de 'conjunto funcciones' se puede poner cualquier cantida 
-- de funciones.
select round(avg(to_number(salary))) from employees;                            -- ATENCION AQUI No son 'Nesting Group Functions'

select avg(to_number(salary)) from employees;                                   -- ATENCION AQUI No son 'Nesting Group Functions'

------------------------------------------------------------------------------------------------------------------ 
--                                                  That GROUP BY clause is mandatory when nesting group functions

select max(avg(salary)) 
from employees;                                                                 -- ERROR

select max(avg(salary)) 
from employees group by department_id;                                          -- NOT ERROR

-- Cuidado aqui para no equivocarse en esta situacion que ocurre en 
-- ejemplo de abajo. No son 'Nesting Group Functions'.
-- Cuando una de las funcciones es 'Single Row Function' el conjunto de estas
-- funcciones no es 'Nesting Group Functions'
-- En este tipo de 'conjunto funcciones' no es obligatorio poner GROUP BY
select round(avg(salary)) from employees;                                       -- ATENCION AQUI No son 'Nesting Group Functions' 
select avg(to_number(salary)) from employees;                                   -- ATENCION AQUI No son 'Nesting Group Functions' 
select round(avg(salary)) from employees group by department_id;                -- ATENCION AQUI No son 'Nesting Group Functions'
select avg(to_number(salary)) from employees group by department_id;            -- ATENCION AQUI No son 'Nesting Group Functions'

--==========================================================================================================================================================
--===================================================================================================================================================== JOIN
--==========================================================================================================================================================

-- Joins that are compliant with the SQL:1999 standard include the following:
--• Natural join with the NATURAL JOIN clause
--• Join with the USING clause
--• Join with the ON clause
--• OUTER joins:
--        LEFT OUTER JOIN
--        RIGHT OUTER JOIN
--        FULL OUTER JOIN
--• Cross joins

-- Note
--• Before the Oracle9i release, the Oracle join syntax was different from the 
--  American National Standards Institute (ANSI) standards. The SQL:1999–compliant 
--  join syntax does not offer any performance benefits over the Oracle-proprietary 
--  join syntax that existed in the prior releases.
--• The following slide discusses the SQL:1999 join syntax.

-- Types of Joins:
--      • Equijoins
--      • Nonequijoins
--      • OUTER joins
--               • Self-joins
--               • Cross joins
--               • Natural joins
--               •Full (or two-sided) OUTER joins

--==========================================================================================================================================================
--============================================================================================================================================ Table Aliases
--==========================================================================================================================================================

-- Table Aliases:
--           • Table aliases speed up database access.
--           • They can help to keep SQL code smaller by conserving memory.
--           • They are sometimes mandatory to avoid column ambiguity.

--==========================================================================================================================================================
--======================================================================================================================== Qualifying Ambiguous Column Names
--==========================================================================================================================================================

-- Use table prefixes to qualify column names that are in multiple tables.
-- Use table prefixes to increase the speed of parsing of the statement.
-- Instead of full table name prefixes, use table aliases.
-- Table alias gives a table a shorter name:
--               Keeps SQL code smaller, uses less memory
-- Use column aliases to distinguish columns that have identical names, but 
-- reside in different tables.

-- When joining two or more tables, you need to qualify the names of the columns 
-- with the table name to avoid ambiguity. Without the table prefixes, the 
-- DEPARTMENT_ID column in the SELECT list could be from either the DEPARTMENTS 
-- table or the EMPLOYEES table. It is necessary to add the table prefix to 
-- execute your query. If there are no common column names between the two 
-- tables, there is no need to qualify the columns. However, using the table 
-- prefix increases the speed of parsing of the statement, because you tell the 
-- Oracle server exactly where to find the columns.
-- However, qualifying column names with table names can be time consuming, 
-- particularly if the table names are lengthy. Instead, you can use table 
-- aliases. Just as a column alias gives a column another name, a table alias 
-- gives a table another name. Table aliases help to keep SQL code smaller, 
-- therefore, using less memory.
-- The table name is specified in full, followed by a space, and then the table 
-- alias. For example, the EMPLOYEES table can be given an alias of e, and the 
-- DEPARTMENTS table an alias of d.

-- Guidelines
--• Table aliases can be up to 30 characters in length, but shorter aliases are 
--  better thanlonger ones.
--• If a table alias is used for a particular table name in the FROM clause, 
--  that table alias must be substituted for the table name throughout the 
--  SELECT statement.
--• Table aliases should be meaningful.
--• The table alias is valid for only the current SELECT statement.


--==========================================================================================================================================================
--============================================================================================================================================= NATURAL JOIN
--==========================================================================================================================================================

-- The NATURAL JOIN clause is based on all the columns that have the same name 
-- in two tables.

-- It selects rows from the two tables that have equal values in all matched 
-- columns.

-- If the columns having the same names have different data types, an error 
-- is returned.

-- Note: The join can happen on only those columns that have the same names 
-- and data types in both tables. If the columns have the same name but 
-- different data types, the NATURAL JOIN syntax causes an error.

-- Natural joins use all columns with matching names and data types to join 
-- the tables. The USING clause can be used to specify only those columns that 
-- should be used for an equijoin.

SELECT * 
FROM employees 
NATURAL JOIN departments;

SELECT employee_id, first_name, job_id, job_title
from employees 
NATURAL JOIN jobs;

SELECT department_id, department_name, location_id, city
FROM departments
NATURAL JOIN locations
WHERE department_id IN (20, 50);

select department_id, department_name, location_id, city 
from departments 
natural join locations;

select department_id, department_name, location_id, city 
from departments 
natural join locations;

------------------------------------------------------------------------------------------------------------------
--                                                                Using Table Aliases with the NATURAL JOIN Clause

-- Do not qualify a column that is used in the NATURAL join or a join with a 
-- USING clause.

-- If the same column is used elsewhere in the SQL statement, do not alias it.

SELECT l.city, d.department_name
FROM locations l 
NATURAL JOIN departments d
WHERE d.location_id = 1400;                                                     -- ERROR

select locations.city, departments.department_name, departments.location_id
from locations 
natural join departments 
where departments.location_id = 1400;                                           -- ERROR

-- Aqui hemos quitado el alias de tabla, y no aparece error
select l.city, d.department_name, location_id 
from locations l 
natural join departments d 
where location_id = 1400;                                                       -- NOT ERROR

select locations.city, departments.department_name, location_id 
from locations 
natural join departments 
where location_id = 1400;                                                       -- NOT ERROR

------------------------------------------------------------------------------------------------------------------
--                                                                        Applying Additional Conditions to a Join

--==========================================================================================================================================================
--==================================================================================================================================================== USING
--==========================================================================================================================================================

-- If several columns have the same names but the data types do not match, use 
-- the USING clause to specify the columns for the equijoin.

-- Use the USING clause to match only one column when more than one column matches.
-- Usa USING en aquella queri donde su nesesita unir tablas solo con un campo

-- Natural joins use all columns with matching names and data types to join 
-- the tables. The USING clause can be used to specify only those columns that 
-- should be used for an equijoin.

-- Campo que se usa con USING, no se permite usar con alias(no se si exactamente 
-- esta cosa se llama alias) en cual quier lugar de query

------------------------------------------------------------------------------------------------------------------

-- Aqui se usa natural join, tenemos los resultados pero no aparecen 
-- todos employees.
-- En este caso query con natural join nos saca employees que tienen 
-- relacionado entre dos tablas con dos campos: 'manager_id' y 'department_id' 
select last_name, salary, department_name from departments natural join employees;

-- Para resolver esta problema se puede usar USING. Con USING se puede conectar 
-- las tablas con un campo solo
select last_name, salary, department_name 
from departments 
join employees 
using(department_id);

select employee_id, last_name,location_id, department_id 
from employees 
join departments 
using(department_id);

------------------------------------------------------------------------------------------------------------------
--                                                                       Using Table Aliases with the USING Clause

-- Aliases
-- Do not qualify a column that is used in the NATURAL join or a join with a 
-- USING clause.
-- If the same column is used elsewhere in the SQL statement, do not alias it.

-- When joining with the USING clause, you cannot qualify a column that is used 
-- in the USING clause itself. Furthermore, if that column is used anywhere in 
-- the SQL statement, you cannot alias it.

SELECT l.city, d.department_name
FROM locations l 
JOIN departments d
USING (location_id)
WHERE d.location_id = 1400;                                                     -- ERROR

select locations.city, departments.department_name, departments.location_id
from locations 
join departments
using(location_id) 
where departments.location_id = 1400;                                           -- ERROR

-- Aqui hemos quitado el alias de tabla, y no aparece error
select l.city, d.department_name, location_id 
from locations l 
join departments d 
using(location_id) 
where location_id = 1400;                                                       -- NOT ERROR

select locations.city, departments.department_name, location_id 
from locations 
join departments 
using(location_id) 
where location_id = 1400;                                                       -- NOT ERROR


-- Campo que se usa con USING, no se permite usar table prefix en cual quier
-- lugar de query

-- Exemplo abajo nos ensena que nosotros usamos campo location_id con 
-- USING(location_id) y en parte select nos ponemos 'd.location' con table 
-- prefix por eso nos da ERROR
select l.city, d.department_name, d.location_id 
from locations l 
join departments d 
using(location_id);                                                             -- ERROR

select locations.city, departments.department_name, departments.location_id 
from locations 
join departments 
using(location_id);                                                             -- ERROR

-- Aqui ya no tenemos esta ERROR que hemos tenido en dos ejemplos que estan 
-- mas ariba, porqu hemos quitado el alias de location_id
select l.city, d.department_name, location_id 
from locations l 
join departments d 
using(location_id);

select locations.city, departments.department_name, location_id 
from locations 
join departments 
using(location_id);

------------------------------------------------------------------------------------------------------------------
--                                                                                        Creating Three-Way Joins

SELECT e.employee_id, l.city, d.department_name
FROM employees e
JOIN departments d
USING (department_id)
JOIN locations l
USING (location_id);

------------------------------------------------------------------------------------------------------------------
--                                                                        Applying Additional Conditions to a Join


SELECT l.city, d.department_name
FROM locations l 
JOIN departments d
USING (location_id)
WHERE location_id = 1400;


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 
--                     Estos dos exmplos no funccionan, tengo que revisar porque
--                     Creocue error es por que los campos en ambas tablad tiene
--                     mismo nombre. Y la queri no sabe a que tabla se refiren 
--                     esta columna

select e.employee_id, e.last_name, d.location_id
from employees e join departments d 
using(department_id) 
and manager_id = 149;

select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from employees e join departments d 
on (e.department_id = d.department_id) 
where e.manager_id = 149;

--==========================================================================================================================================================
--================================================================================================================================================== JOIN ON
--==========================================================================================================================================================

-- The join condition for the natural join is basically an equijoin of all 
-- columns with the same name.
-- Use the ON clause to specify arbitrary conditions or specify columns to join.
-- The join condition is separated from other search conditions.
-- The ON clause makes code easy to understand.

-- Use the ON clause to specify a join condition. With this, you can specify join 
-- conditions separate from any search or filter conditions in the WHERE clause.

-- Prefiksu yvelichevayt skorost
-- FK = PK

-- Note: When you use the Execute Statement icon to run the query, SQL Developer
-- suffixes a ‘_1’ to differentiate between the two department_ids.

------------------------------------------------------------------------------------------------------------------
-- In this example, the DEPARTMENT_ID columns in the EMPLOYEES and DEPARTMENTS 
-- table are joined using the ON clause. Wherever a department ID in the 
-- EMPLOYEES table equals a department ID in the DEPARTMENTS table, the row is 
-- returned. 
select e.employee_id, e.last_name, e.department_id, d.department_id, 
       d.location_id 
from employees e 
join departments d 
on(e.department_id = d.department_id);

------------------------------------------------------------------------------------------------------------------
-- The table alias is necessary to qualify the matching column_names.

select e.last_name, e.salary, department_name, department_id 
from departments d 
join employees e 
on (e.department_id = d.department_id);                                         -- ERROR

select e.last_name, e.salary, d.department_name, d.department_id 
from departments d 
join employees e 
on (e.department_id = d.department_id);                                         -- NOT ERROR

------------------------------------------------------------------------------------------------------------------
-- You can also use the ON clause to join columns that have different names. 

-- Palabra clave 'ON' se puede usar cuando campos de 
-- relacion('ForenKey' y 'PrimaryKey') tienen diferentes nombres de campos por 
-- exemplo 'e.department_id' y 'd.depar_id'
-- Nosotros no tenemos tablas con differentes nombres de campos, 
-- por eso usamos (e.department_id = d.department_id)
select e.last_name, e.salary, d.department_name, d.department_id 
from departments d 
join employees e 
on (e.department_id = d.department_id);

------------------------------------------------------------------------------------------------------------------
-- The parentheses around the joined columns, as in the example in the slide, 
-- (e.department_id = d.department_id) is optional. 
-- So, even ON e.department_id = d.department_id will work.

select e.last_name, e.salary, d.department_name, d.department_id 
from departments d 
join employees e 
on (e.department_id = d.department_id);                                         

select e.last_name, e.salary, d.department_name, d.department_id 
from departments d 
join employees e 
on e.department_id = d.department_id;                                           -- NOT ERROR


------------------------------------------------------------------------------------------------------------------
--                                                                                        Creating Three-Way Joins

SELECT employee_id, city, department_name
FROM employees e
JOIN departments d
ON d.department_id = e.department_id
JOIN locations l
ON d.location_id = l.location_id;

select first_name ||' '|| last_name "Full Name", 
       department_name "Department", city 
from employees e 
join departments d 
on d.department_id = e.department_id 
join locations l 
on d.location_id = l.location_id;

------------------------------------------------------------------------------------------------------------------
--                                                                        Applying Additional Conditions to a Join

-- You can apply additional conditions to the join.
-- The example shown performs a join on the EMPLOYEES and DEPARTMENTS tables 
-- and, in addition, displays only employees who have a manager ID of 149. To 
-- add additional conditions to the ON clause, you can add AND clauses. 
-- Alternatively, you can use a WHERE clause to apply additional conditions.
-- Both the queries produce the same output.

select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from employees e join departments d 
on (e.department_id = d.department_id) 
and e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from employees e join departments d 
on (e.department_id = d.department_id) 
where e.manager_id = 149;

--==========================================================================================================================================================
--=============================================================================================================================================== Self Joins
--==========================================================================================================================================================

------------------------------------------------------------------------------------------------------------------
--                                                                                  Self-Joins Using the ON Clause

-- The ON clause can also be used to join columns that have different names, 
-- within the same table or in a different table.

-- The example shown is a self-join of the EMPLOYEES table, based on the 
-- EMPLOYEE_ID and MANAGER_ID columns.

SELECT worker.last_name emp, manager.last_name mgr
FROM employees worker 
JOIN employees manager
ON(worker.manager_id = manager.employee_id);

--==========================================================================================================================================================
--============================================================================================================================================= Nonequijoins
--==========================================================================================================================================================

-- A nonequijoin is a join condition containing something other than an equality 
-- operator.
-- The relationship between the EMPLOYEES table and the JOB_GRADES table is an 
-- example of a nonequijoin. The SALARY column in the EMPLOYEES table ranges 
-- between the values in the LOWEST_SAL and HIGHEST_SAL columns of the 
-- JOB_GRADES table. Therefore, each employee can be graded based on their salary. 
-- The relationship is obtained using an operator other than the 
-- equality (=) operator

------------------------------------------------------------------------------------------------------------------
--                                                                                  Self-Joins Using the ON Clause

-- Note: 
--       Other conditions (such as <= and >=) can be used, but BETWEEN is the 
--       simplest.

--       Remember to specify the low value first and the high value last when 
--       using the BETWEEN condition. The Oracle server translates the BETWEEN 
--       condition to a pair of AND conditions.

--       Therefore, using BETWEEN has no performance benefits, but should be 
--       used only for logical simplicity.

--       Table aliases have been specified in the slide example for performance 
--       reasons, not because of possible ambiguity.


-- The example in the slide creates a nonequijoin to evaluate an employee’s 
-- salary grade. The salary must be between any pair of the low and high salary 
-- ranges.

-- It is important to note that all employees appear exactly once when this 
-- query is executed. No employee is repeated in the list. There are two 
-- reasons for this:
--         • None of the rows in the JOB_GRADES table contain grades that 
--           overlap. That is, the salary value for an employee can lie only 
--           between the low-salary and high-salary values of one of the rows 
--           in the salary grade table.
--         • All of the employees’ salaries lie within the limits provided by 
--           the job grade table. That is, no employee earns less than the lowest 
--           value contained in the LOWEST_SAL column or more than the highest 
--           value contained in the HIGHEST_SAL column.

SELECT e.last_name, e.salary, j.grade_level
FROM employees e 
JOIN job_grades j
ON e.salary
BETWEEN j.lowest_sal AND j.highest_sal;

select * from job_grades; 


--==========================================================================================================================================================
--=============================================================================================================================================== OUTER JOIN
--==========================================================================================================================================================

-- In SQL:1999, the join of two tables returning only matched rows is called 
-- an INNER join.

-- A join between two tables that returns the results of the INNER join as well 
-- as the unmatched rows from the left (or right) table is called a left 
-- (or right) OUTER join.

-- A join between two tables that returns the results of an INNER join as well 
-- as the results of a left and right join is a full OUTER join.

-- Joining tables with the NATURAL JOIN, USING, or ON clauses results in an 
-- INNER join. Any unmatched rows are not displayed in the output. To return the 
-- unmatched rows, you can use an OUTER join. An OUTER join returns all rows 
-- that satisfy the join condition and also returns some or all of those rows 
-- from one table for which no rows from the other table satisfy the join condition.

--There are three types of OUTER joins:
--                LEFT OUTER
--                RIGHT OUTER
--                FULL OUTER

--==========================================================================================================================================================
--========================================================================================================================================== LEFT OUTER JOIN
--==========================================================================================================================================================

-- This query retrieves all the rows in the EMPLOYEES table, which is the left 
-- table, even if there is no match in the DEPARTMENTS table.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON(e.department_id = d.department_id) ;

--==========================================================================================================================================================
--========================================================================================================================================= RIGHT OUTER JOIN
--==========================================================================================================================================================

-- This query retrieves all the rows in the DEPARTMENTS table, which is the 
-- table at the right, even if there is no match in the EMPLOYEES table.
SELECT e.last_name, d.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON(e.department_id = d.department_id) ;

--==========================================================================================================================================================
--========================================================================================================================================== FULL OUTER JOIN
--==========================================================================================================================================================

-- This query retrieves all rows in the EMPLOYEES table, even if there is no 
-- match in the DEPARTMENTS table. 
-- It also retrieves all rows in the DEPARTMENTS table, even if there is no
-- match in the EMPLOYEES table.
SELECT e.last_name, d.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON(e.department_id = d.department_id) ;

--==========================================================================================================================================================
--======================================================================================================================================= Cartesian Products
--==========================================================================================================================================================

-- Cartesian product is a join of every row of one table to every row of 
-- another table.

-- A Cartesian product generates a large number of rows and the result is 
-- rarely useful.

-- A Cartesian product tends to generate a large number of rows and the result 
-- is rarely useful.
-- You should, therefore, always include a valid join condition unless you have 
-- a specific need to combine all rows from all tables.
-- Cartesian products are useful for some tests when you need to generate a large 
-- number of rows to simulate a reasonable amount of data.

-- A Cartesian product is generated if a join condition is omitted.

-- Cartesian Products
-- A Cartesian product results in the display of all combinations of rows. This 
-- is done by either omitting the WHERE clause or specifying the CROSS JOIN clause.

--==========================================================================================================================================================
--============================================================================================================================================== Cross Joins
--==========================================================================================================================================================

-- A CROSS JOIN is a JOIN operation that produces the Cartesian product of two tables.
-- To create a Cartesian product, specify the CROSS JOIN in your SELECT statement.

-- The example in the slide produces a Cartesian product of the EMPLOYEES 
-- and DEPARTMENTS tables.
-- It is a good practice to explicitly state CROSS JOIN in your SELECT when you 
-- intend to create a Cartesian product. Therefore, it is very clear that you 
-- intend for this to happen and it is not the result of missing joins.
SELECT last_name, department_name
FROM employees
CROSS JOIN departments ;

--==========================================================================================================================================================
--================================================================================================================================================= Subquery
--==========================================================================================================================================================

-- Single-row subquerie
-- Multiple-row subquerie
-- Multiple-column subquerie

-- The inner query (or subquery) returns a value that is used by the outer 
-- query (or main query).
-- The execution plan of the query depends on the optimizer’s decision on the 
-- structure of the subquery.

-- The subquery (inner query) executes before the main query (outer query).
-- The result of the subquery is used by the main query.

-- A subquery is a SELECT statement that is embedded in the clause of another 
-- SELECT statement. You can build powerful statements out of simple ones by 
-- using subqueries. They can be very useful when you need to select rows from 
-- a table with a condition that depends on the data in the table itself.

-- You can place the subquery in a number of SQL clauses, including the following:
--     • WHERE clause
--     • HAVING clause
--     • FROM clause

-- In the syntax:
-- operator includes a comparison condition such as >, =, or IN

-- The subquery is often referred to as a nested SELECT, sub-SELECT, or 
-- inner SELECT statement. The subquery generally executes first, and its output 
-- is used to complete the query condition for the main (or outer) query.

-- Rules and Guidelines for Using Subqueries:
--        * Enclose subqueries in parentheses.
--        * Place subqueries on the right side of the comparison condition for 
--          readability. (However, the subquery can appear on either side of the 
--          comparison operator.)
--        * Use single-row operators with single-row subqueries and multiple-row 
--          operators with multiple-row subqueries.

-- • A subquery must be enclosed in parentheses.
-- • Place the subquery on the right side of the comparison condition for 
--   readability. However, the subquery can appear on either side of the 
--   comparison operator.
-- • Two classes of comparison conditions are used in subqueries: single-row 
--   operators and multiple-row operators.

-- • Single-row subqueries: Queries that return only one row from the inner 
--   SELECT statement
-- • Multiple-row subqueries: Queries that return more than one row from the 
--   inner SELECT statement

-- Note: There are also multiple-column subqueries, which are queries that 
-- return more than one column from the inner SELECT statement. These are covered 
-- in the Oracle Database: SQL Workshop II course.

-- A subquery is a SELECT statement that is embedded in the clause of another 
-- SQL statement. Subqueries are useful when a query is based on a search 
-- criterion with unknown intermediate values.

-- Subqueries have the following characteristics:
--     • Can pass one row of data to a main statement that contains a single-row 
--       operator, such as =, <>, >, >=, <, or <=
--     • Can pass multiple rows of data to a main statement that contains a 
--       multiple-row operator, such as IN
--     • Are processed first by the Oracle server, after which the WHERE or HAVING 
--       clause uses the results
--     • Can contain group functions


-- For practice questions, you may want to create the inner query first. Make 
-- sure that it runs and produces the data that you anticipate before you code 
-- the outer query.

------------------------------------------------------------------------------------------------------------------              
--                                                                                       Null Values in a Subquery

-- The SQL statement in the slide attempts to display all the employees who do 
-- not have any subordinates. Logically, this SQL statement should have returned 
-- 12 rows. However, the SQL statement does not return any rows. One of the 
-- values returned by the inner query is a null value and, therefore, the entire 
-- query returns no rows.
-- The reason is that all conditions that compare a null value result in a null. 
-- So whenever null values are likely to be part of the results set of a subquery, 
-- do not use the NOT IN operator.
-- The NOT IN operator is equivalent to <> ALL.
-- Notice that the null value as part of the results set of a subquery is not a 
-- problem if you use the IN operator. The IN operator is equivalent to =ANY. 

-- Subquery returns no rows because one of the values returned by a subquery is null.
SELECT emp.last_name
FROM employees emp
WHERE emp.employee_id NOT IN (SELECT mgr.manager_id
                              FROM employees mgr);

-- For example, to display the employees who have subordinates, use the 
-- following SQL statement:
SELECT mgr.manager_id
FROM employees mgr;
-- Inner query return: all values for managers
SELECT emp.last_name
FROM employees emp
WHERE emp.employee_id IN (SELECT mgr.manager_id
                          FROM employees mgr);
                          
-- Alternatively, a WHERE clause can be included in the subquery to display all 
-- employees who do not have any subordinates:
SELECT last_name, manager_id FROM employees
WHERE employee_id NOT IN (SELECT manager_id
                          FROM employees
                          WHERE manager_id IS NOT NULL);

--==========================================================================================================================================================
--==================================================================================================================================== Single-Row Subqueries
--==========================================================================================================================================================

-- * Return only one row
-- * Use single-row comparison operators

-- A single-row subquery is one that returns one row from the inner SELECT 
-- statement. This type of subquery uses a single-row operator. The slide gives 
-- a list of single-row operators.

-- Note: The outer and inner queries can get data from different tables.

-- Single-Row Subcueries work for this conditon:
--  =    Equal to
--  >    Greater than
--  >=   Greater than or equal to
--  <    Less than
--  <=   Less than or equal to
--  <>   Not equal to

------------------------------------------------------------------------------------------------------------------ 

-- In the slide, the inner query determines the hire date of the employee Davies. 
-- The outer query takes the result of the inner query and uses this result to 
-- display all the employees who were hired after Davies.
-- Inner query return the result - 29-JAN-05
SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE last_name = 'Davies');

-- Sub Query se puede usar en qual quier parte de select
select (select sysdate from dual), (select current_date from dual) from dual;

-- Aqui sub query devuelve un resultado. Y si sub query devuelve un reusltado 
-- se permite usar operadores: >, =>, <, =<, <>, =! ...
select last_name, department_id, job_id 
from employees
where employee_id = (select employee_id 
                     from employees
                     where last_name = 'King');
                     
-- Display the employees whose job ID is the same as that of employee 141:
SELECT last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 141);
                     
select last_name, salary 
from employees
where manager_id = (select employee_id 
                     from employees
                     where last_name = 'King');

------------------------------------------------------------------------------------------------------------------ 
--                                                                                 Executing Single-Row Subqueries

-- A SELECT statement can be considered as a query block. The example in the 
-- slide displays employees who do the same job as “Taylor,” but earn more salary 
-- than him.
-- The example consists of three query blocks: the outer query and two inner 
-- queries. The inner query blocks are executed first, producing the query 
-- results SA_REP and 8600, respectively.
-- The outer query block is then processed and uses the values that were 
-- returned by the inner queries to complete its search conditions.
-- Both inner queries return single values (SA_REP and 8600, respectively), so 
-- this SQL statement is called a single-row subquery.

--Note: The outer and inner queries can get data from different tables.


-- First inner query return - SA_REP
-- Second inner query return - 8600
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE last_name = 'Taylor')
AND salary > (SELECT salary
              FROM employees
              WHERE last_name = 'Taylor');

------------------------------------------------------------------------------------------------------------------              
--                                                                             Using Group Functions in a Subquery

-- You can display data from a main query by using a group function in a subquery 
-- to return a single row. The subquery is in parentheses and is placed after 
-- the comparison condition.

-- The example in the slide displays the employee last name, job ID, and salary 
-- of all employees whose salary is equal to the minimum salary. The MIN group 
-- function returns a single value (2500) to the outer query.
-- Inner query return - 2500
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);

------------------------------------------------------------------------------------------------------------------              
--                                                                                   HAVING Clause with Subqueries
-- Inner query return - 2500
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary)
                      FROM employees
                      WHERE department_id = 20);
                 
                      
SELECT job_id, AVG(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) = (SELECT MIN(AVG(salary))
                      FROM employees
                      GROUP BY job_id);

------------------------------------------------------------------------------------------------------------------              
--                                                                             No Rows Returned by the Inner Query

-- Another common problem with subqueries occurs when no rows are returned by 
-- the inner query.
-- In the SQL statement in the slide, the subquery contains a WHERE clause. 
-- Presumably, the intention is to find the employee whose name is Haas. The 
-- statement is correct, but selects no rows when executed because there is no 
-- employee named Haas. Therefore, the subquery returns no rows.
-- The outer query takes the results of the subquery (null) and uses these 
-- results in its WHERE clause. The outer query finds no employee with a job ID 
-- equal to NULL, and so returns no rows. If a job existed with a value of null, 
-- the row is not returned because comparison of two null values yields a null; 
-- therefore, the WHERE condition is not true.

SELECT last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE last_name = 'Haas');

--==========================================================================================================================================================
--================================================================================================================================== Multiple-Row Subqueries
--==========================================================================================================================================================

-- Return more than one row
-- Use multiple-row comparison operators

-- IN   Equal to any member in the list

-- ANY  Must be preceded by = , != , > , < , <= , >= . Returns TRUE if at least 
--      one element exists in the result set of the subquery for which the 
--      relation is TRUE .

-- ALL  Must be preceded by = , != , > , < , <= , >= . Returns TRUE if the 
--      relation is TRUE for all elements in the result set of the subquery.

-- Sub query que devuelve varios resultados no se permite usar 
-- operacines: >, =>, <, =<, <>, =! ...

-- En sub query que devuelve varios resultados solo se permite usar los 
-- operdores: >, =>, <, =<, <>, =! ... con palabras claves 'ANY' y 'ALL'

-- Subqueries that return more than one row are called multiple-row subqueries. 
-- You use a multiple-row operator, instead of a single-row operator, with a 
-- multiple-row subquery. 
-- The multiple-row operator expects one or more values:

SELECT last_name, salary, department_id
FROM employees
WHERE salary IN (SELECT MIN(salary)
                 FROM employees
                 GROUP BY department_id);
                 
-- Find the employees who earn the same salary as the minimum salary for each 
-- department.
-- The inner query is executed first, producing a query result. The main query 
-- block is then processed and uses the values that were returned by the inner 
-- query to complete its search condition. In fact, the main query appears to 
-- the Oracle server as follows:

SELECT last_name, salary, department_id
FROM employees
WHERE salary 
IN (2500, 4200, 4400, 6000, 7000, 8300, 8600, 17000);

-- Error. Segunda sub query devuelve varios resultados. Y con operador  '=' no 
-- se puede comparar un registro con varos ala vez.
select last_name, department_id, job_id
from employees
where department_id = (select department_id
                       from departments
                       where location_id = 1700);                               -- ERROR

-- A common error with subqueries occurs when more than one row is returned for 
-- a single-row subquery.
-- In the SQL statement in the slide, the subquery contains a GROUP BY clause, 
-- which implies that the subquery will return multiple rows, one for each group 
-- that it finds. In this case, the results of the subquery are 4400, 6000, 
-- 2500, 4200, 7000, 17000, and 8300.
-- The outer query takes those results and uses them in its WHERE clause. 
-- The WHERE clause contains an equal (=) operator, a single-row comparison 
-- operator that expects only one value.
-- The = operator cannot accept more than one value from the subquery and, 
-- therefore, generates the error.

--To correct this error, change the = operator to IN.

-- Single-row operator with multiple-row subquery                       
SELECT employee_id, last_name
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees
                GROUP BY department_id);                                        --ERROR
                       
SELECT employee_id, last_name
FROM employees
WHERE salary in (SELECT MIN(salary)
                FROM employees
                GROUP BY department_id);                                        -- NOT ERROR
                      
-- Con operadores: 'IN', 'ANY', 'ALL' se permite comparar un reusltado 
-- con varios resultados    
select last_name, department_id, job_id
from employees
where department_id IN (select department_id
                       from departments
                       where location_id = 1700);                               -- NOT ERROR

select last_name, department_id, job_id
from employees
where department_id = ANY (select department_id
                       from departments
                       where location_id = 1700);                               

select last_name, department_id, job_id
from employees
where department_id <= ALL (select department_id
                       from departments
                       where location_id = 1700);                               

------------------------------------------------------------------------------------------------------------------              
--                                                               Using the ANY Operator in Multiple-Row Subqueries

-- The ANY operator (and its synonym, the SOME operator) compares a value to 
-- each value returned by a subquery. The slide example displays employees who 
-- are not IT programmers and whose salary is less than that of any IT programmer. 
-- The maximum salary that a programmer earns is $9,000.
--       •  <ANY means less than the maximum.
--       •  >ANY means more than the minimum.
--       •  =ANY is equivalent to IN.

-- Inner query return: 9000, 6000, 4200
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';

------------------------------------------------------------------------------------------------------------------              
--                                                               Using the ALL Operator in Multiple-Row Subqueries

-- The ALL operator compares a value to every value returned by a subquery. The 
-- example in the slide displays employees whose salary is less than the salary 
-- of all employees with a job ID of IT_PROG and whose job is not IT_PROG.
-- >ALL means more than the maximum and <ALL means less than the minimum.

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar informacion
-- The NOT operator can be used with IN, ANY, and ALL operators.

SELECT salary
FROM employees
WHERE job_id = 'IT_PROG';
-- Inner query return: 9000, 6000, 4200
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';

------------------------------------------------------------------------------------------------------------------              

--Este ejamplo no funccion
select(select sum(salary) from employees where department_id = 50),
      (select max(salary) from employees where department_id = 10) from dual;
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Buscar informacion

------------------------------------------------------------------------------------------------------------------              
--                                                                             Using Group Functions in a Subquery


------------------------------------------------------------------------------------------------------------------              
--                                                                                   HAVING Clause with Subqueries


------------------------------------------------------------------------------------------------------------------              
--                                                                             No Rows Returned by the Inner Query

-- Another common problem with subqueries occurs when no rows are returned by 
-- the inner query.
-- In the SQL statement in the slide, the subquery contains a WHERE clause. 
-- Presumably, the intention is to find the employee whose name is Haas. The 
-- statement is correct, but selects no rows when executed because there is no 
-- employee named Haas. Therefore, the subquery returns no rows.
-- The outer query takes the results of the subquery (null) and uses these 
-- results in its WHERE clause. The outer query finds no employee with a job ID 
-- equal to NULL, and so returns no rows. If a job existed with a value of null, 
-- the row is not returned because comparison of two null values yields a null; 
-- therefore, the WHERE condition is not true.

SELECT job_id
FROM employees
WHERE last_name = 'Haas';
-- Inner query return: Null
SELECT last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE last_name = 'Haas');
                
--==========================================================================================================================================================
--=============================================================================================================================== Multiple-Column Subqueries 
--==========================================================================================================================================================

-- A multiple-column subquery returns more than one column to the outer query.

-- Column comparisons in multiple column comparisons can be pairwise or nonpairwise.

-- A multiple-column subquery can also be used in the FROM clause of a SELECT statement.

-- A multiple-column subquery returns more than one column to the outer query 
-- and can be listed in the outer query’s FROM, WHERE, or HAVING clause.
-- If you want to compare two or more columns, you must write a compound WHERE 
-- clause using logical operators. Multiple-column subqueries enable you to 
-- combine duplicate WHERE conditions into a single WHERE clause.
-- IN operator is used to check a value within a set of values. The list of 
-- values may come from the results returned by a subquery.

-- The example in the slide is that of a multiple-column subquery because the 
-- subquery returns more than one column.
-- The inner query is executed first, and it returns the lowest salary and 
-- department_id for each department. The main query block is then processed 
-- and uses the values that were returned by the inner query to complete its 
-- search condition.

SELECT min(salary), department_id
FROM employees
GROUP BY department_id;
-- Inner query return: 7000, 17000, 6000, 8300, 2500, 8600, 4200, 4400
-- Display all the employees with the lowest salary in each department
SELECT first_name, department_id, salary
FROM employees
WHERE (salary, department_id) IN (SELECT min(salary), department_id
                                  FROM employees
                                  GROUP BY department_id)
ORDER BY department_id;

--==========================================================================================================================================================
--================================================================================================================================= Implicit data conversion 
--==========================================================================================================================================================
select 1 + '3' from dual;

select 1 ||  ' algun cantidad de characteres ' || 45 from dual;

select * from employees where hire_date > '01-jan-2007';

-- Atencion aqui, hay que poner la fecha en formato que esta puesto en ajustes
select * from employees where hire_date > '01-01-2007';

--==========================================================================================================================================================
--=================================================================================================================================================== Others
--==========================================================================================================================================================
-- Para sqlplus, hacer las linias mas anchas:     set linesize 2000
-- para repitir linia:      l

-- show parameter nls
-- alter system set 
-- alter session set nls_date_format='DD/MM/YYYY'  

sqlplus / as sysdba
alter user ora1 identified by ora1 account unlock;
alter user hr identified by hr account unlock;

conn / as sysdba;
select username from dba_users;
select username from dba_users order by 1;








