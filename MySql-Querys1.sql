-- Student: Isaías Daniel Cabana
-- MYSQL QUERYS
select * from tabla_emple;
select * from tabla_dept;

alter table tabla_dept add primary key (numdep); -- add primary key

-- añado un fk entre tabla_empl y tabla_dept
ALTER TABLE `db_ejercicio1`.`tabla_emple` 
ADD INDEX `fk_id_dept_numdep_idx` (`id_dept` ASC) VISIBLE;
;
ALTER TABLE `db_ejercicio1`.`tabla_emple` 
ADD CONSTRAINT `fk_id_dept_numdep`
  FOREIGN KEY (`id_dept`)
  REFERENCES `db_ejercicio1`.`tabla_dept` (`numdep`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
/* 1) Obtener una lista de todos las empleados de los departamentos que
empiecen por D y por E. La lista anterior debe contener información sobre el
número de personal, nombre, apellido y número de teléfono */
select emp.nombre as nomEmp, emp.apellido as apeEmp, tlfn 
from tabla_emple as emp inner join tabla_dept as depa 
where emp.id_dept = depa.numdep and (depa.numdep like 'D%' or depa.numdep like 'E%');

/*2.- Obtener un listado de todos los empleados (nombre y apellido) que ganan
más de 2000€ al mes y que entraron en la compañía después del 1 de Enero
de 1975. También se quiere la información correspondiente a su código de
trabajo y al número de personal de sus directores.
*/
select emp.nombre nomEmp, emp.apellido, emp.codtra, depa.numdirec 
from tabla_emple emp inner join tabla_dept depa 
where emp.id_dept = depa.numdep and (emp.salario > 2000 and emp.feching > '1970-01-01');

/*3.- Obtener una lista con el apellido, número de departamento y salario
mensual de los empleados de los departamentos ‘A00’, ‘B01’, ‘C01’ y ‘D01’. 
La salida se quiere en orden descendente de salario dentro de cada
departamento.
*/
select emp.apellido, depa.numdep, emp.salario from tabla_emple emp inner join tabla_dept depa 
where emp.id_dept = depa.numdep and (depa.numdep like 'A00' or depa.numdep like 'B01' or depa.numdep like 'C01' or depa.numdep like 'D01') 
order by depa.numdep, emp.salario desc;

/*4.- Se pide una lista que recupere el salario medio de cada departamento junto
con el número de empleados que tiene. El resultado no debe incluir empleados
que tengan un código de trabajo mayor que 54, ni departamentos con menos
de tres empleados. Se quiere ordenada por número de departamento.
PENDIENTE
*/
-- primer select 
-- select avg(emp.salario) promSal, count(*) numEmp from tabla_dept depa inner join tabla_emple emp where emp.id_dept = depa.numdep and emp.codtra <=54 group by depa.numdep;

-- Select final
select * from (select avg(emp.salario) promSal, count(*) numEmp from tabla_dept depa inner join tabla_emple emp where emp.id_dept = depa.numdep and emp.codtra <=54 group by depa.numdep) as resultado where numEmp > 3;
/*5.- Seleccionar todos los empleados de los departamentos ‘D11’ y ‘E11’ cuyo
primer apellido empiece por S
*/
select * from tabla_emple emp inner join tabla_dept depa 
where emp.id_dept = depa.numdep and (depa.numdep like 'D11' or depa.numdep like 'E11') and emp.apellido like 'S%'; 

/*6.- Obtener el nombre, apellido y fecha de ingreso de los directores de
departamento ordenados por número de personal.
PENDIENTE
*/
select emp.nombre, emp.apellido, depa. from tabla_emple emp inner join tabla_dept depa 
where emp.id_dept = depa.numdep and (depa.numdep like 'D11' or depa.numdep like 'E11') and emp.apellido like 'S%';

/*7.- Obtener un listado de las mujeres de los departamentos que empiecen por
D o por E cuyo nivel de educación sea superior a la media; en este caso
también ordenados por número de personal.
*/
	/*select @promedu := avg(emp.niveduc) as promedu from tabla_emple emp;
	select avg(emp.niveduc) as promedu from tabla_emple emp;

	select emp.nombre from tabla_emple emp inner join tabla_dept depa 
	where emp.id_dept = depa.numdep and (depa.numdep like 'D%' or depa.numdep like 'E%') and emp.niveduc > 51.5;*/
select * from tabla_emple emp inner join tabla_dept depa 
where emp.id_dept = depa.numdep and (depa.numdep like 'D%' or depa.numdep like 'E%') and emp.niveduc > (select avg(emp.niveduc) as promedu from tabla_emple emp);

/*8.- Seleccionar todos los empleados cuyo nombre sea igual al de algunas
personas del departamento D21 y cuyo código de trabajo sea diferente de
todos los del E21 (la lista debe contener el número de personal, nombre,
apellido, departamento y código de trabajo).
*/
