

/* EJEMPLO union, muestra las ciudades de ambas tablas, sin repeticion*/
SELECT Pais
FROM Clientes
UNION
SELECT Pais
FROM Proyectos;

/* EJEMPLO UNION ALL, muestra las ciudades de ambas tablas, con repeticion*/
SELECT Pais
FROM Clientes
UNION ALL
SELECT Pais
FROM Proyectos;


/* EJEMPLO UNION con ORDER BY, muestra las ciudades de ambas tablas,
sin repeticion y ordenado alfabeticamente*/

(SELECT Pais
FROM Clientes)
UNION
(SELECT Pais
FROM Proyectos)
ORDER BY Pais;


/* EJEMPLO UNION ALL con LIMIT, muestra las ciudades de ambas tablas,
 con repeticion, limitando los resultados a las 6 primeros registros*/

SELECT Pais
FROM Clientes
UNION ALL
SELECT Pais
FROM Proyectos
ORDER BY Pais
LIMIT 6;


/* EJEMPLO INTERCEPT, muestra aquellas ciudades de ambas tablas cuyos registros son iguales*/
 
SELECT Ciudad
FROM Clientes
WHERE Ciudad IN(
SELECT Ciudad
FROM Proyectos);
 
 
 /* EJEMPLO EXCEPT , devuelve las ciudades de la tabla clientes, que no se encuentran en la tabla proyectos*/
 
 
SELECT Ciudad
FROM Clientes
WHERE Ciudad NOT IN(
SELECT Ciudad
FROM Proyectos);

# EJERCICIOS FINALES

USE tienda;

/* EJERCICIO 1: Selecciona los apellidos que se encuentren en ambas tablas para employees y customers, con alias 'Apellidos'. */
 
 
 SELECT lastName AS 'Apellido'
 FROM employees
 UNION 
 SELECT contactfirstName AS 'Apellido'
 FROM customers;
 
/* EJERCICIO 2: Selecciona los nombres con alias 'Nombre' y apellidos,
 con alias 'Apellidos' tanto de los clientes como de los empleados de las tablas employees y customers. */
 
 SELECT firstName AS 'Nombre', lastName AS 'Apellido'
 FROM employees
 UNION
 SELECT contactFirstName AS 'Nombre ', contactfirstName as 'Apellido'
 FROM customers;
 
/* EJERCICIO 3: Selecciona todos los nombres con alias 'Nombre' y apellidos,
 con alias 'Apellidos', tanto de los clientes como de los empleados de las tablas employees y customers. */
 SELECT firstName AS 'Nombre', lastName AS 'Apellido'
 FROM employees
 UNION ALL
 SELECT contactFirstName AS 'Nombre ', contactfirstName as 'Apellido'
 FROM customers;
 
/* EJERCICIO 4: Queremos ver ahora que empleados tienen algun contrato asignado con alguno de los clientes existentes.
 Para ello selecciona employeeNumber como 'Número empleado', firstName como 'Nombre Empleado' y lastName como 'Apellido Empleado' */
 
 SELECT employeeNumber AS 'Número empleado'  ,firstName AS 'Nombre Empleado', lastName AS 'Apellido Empleado'
 FROM employees
 WHERE employeeNumber IN( 
 SELECT salesRepEmployeeNumber
 FROM customers);
 
/* EJERCICIO 5: Queremos ver ahora en cuantas ciudades en las cuales tenemos clientes,
 no tambien una oficina de nuestra empresa para ello.
 Selecciona aquellas ciudades como 'Ciudad' y los nombres de las empresas como 'Nombre de la empresa '
 de la tabla customers, sin repeticiones, que no tengan una oficina en dicha ciudad de la tabla offices. */
 
 SELECT DISTINCT city AS 'Ciudad'
 FROM customers
 WHERE city NOT IN(
 SELECT city FROM offices);
 
 SELECT * FROM offices
 LIMIT 10;
 
 
 