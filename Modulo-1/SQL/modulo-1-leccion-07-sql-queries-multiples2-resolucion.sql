

/*LEFT JOIN*/
/*EJEMPLO : Obtener el nombre, apellido y el ID en proyecto de la tablas empleadas y proyectos
, utilizando un LEFT JOIN*/
SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto
FROM Empleadas
LEFT JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;


/*RIGHT JOIN*/
/*EJEMPLO : Obtener el nombre, apellido y el ID en proyecto de la tablas empleadas y proyectos
, utilizando un RIGHT JOIN*/

SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto
FROM Empleadas
RIGHT JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;

/*FULL JOIN*/
/*Ejemplo:** Seleccionamos los nombres y apellidos de todas las empleadas de la tabla Empleada,
 así como los IDProyecto de todos los proyectos de la tabla EmpleadasEnProyectos.
 Si alguna de las empleadas está asignada a un proyecto, se indicará en el resultado*/

SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto
FROM Empleadas
LEFT JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada
UNION
SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto
FROM Empleadas
RIGHT JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;



/*SELF JOIN*/
/**EJEMPLO :seleccionar parejas de empleadas del mismo país y visualizar sus salarios, 
lo cual puede resultar útil para encontrar diferencias significativas entre ellos
 e investigar la causa. */
 
SELECT A.Nombre AS Nombre1, A.Apellido AS Apellido1, A.Salario AS Salario1, B.Nombre AS Nombre2, B.Apellido AS Apellido2, B.Salario AS Salario2, A.Pais 
FROM Empleadas A, Empleadas B
WHERE A.IDEmpleada <> B.IDEmpleada
AND A.Pais = B.Pais;

/*EJERCICIOS FINALES*/

USE tienda;


/*EJERCICIO 1
Selecciona el ID, nombre, apellidos de todas las empleadas y el ID de cada cliente asociado a ellas (si es que lo tienen)*/


SELECT employees.employeeNumber, employees.firstName, employees.lastName, customers.customerNumber
FROM employees LEFT JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber;

/*EJERCICIO 2
Selecciona el ID de todos los clientes, y el nombre, apellidos de las empleadas que llevan sus pedidos (si es que las hay):*/

SELECT customers.customerNumber, employees.employeeNumber, employees.firstName, employees.lastName
FROM employees RIGHT JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber;

/*EJERCICIO 3
Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando LEFT JOIN:*/

SELECT employees.employeeNumber, employees.firstName, employees.lastName
FROM employees LEFT JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY (employees.employeeNumber)
HAVING COUNT(DISTINCT customers.customerNumber)>8;

/*EJERCICIO 4
Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando RIGHT JOIN:*/

SELECT employees.employeeNumber, employees.firstName, employees.lastName
FROM customers RIGHT JOIN employees
ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY (employees.employeeNumber)
HAVING COUNT(DISTINCT customers.customerNumber)>8;

/*EJERCICIO 5
Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando LEFT JOIN:*/

SELECT employees.employeeNumber, employees.firstName, employees.lastName, COUNT(DISTINCT customers.country) AS PaisesClientes
FROM employees LEFT JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY (employees.employeeNumber)
HAVING COUNT(DISTINCT customers.country)>1;