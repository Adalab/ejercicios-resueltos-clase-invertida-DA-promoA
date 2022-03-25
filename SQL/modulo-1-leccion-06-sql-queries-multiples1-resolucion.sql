
/* CROSS JOIN */
/*Ejemplo: Seleccionar los nombres y apellidos de cada empleada y a que proyectos pertenece cada una*/
SELECT Empleadas.Nombre, Empleadas.Apellido, EmpleadasEnProyectos.IDProyecto   
FROM Empleadas, EmpleadasEnProyectos  
WHERE Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;

/* EJERCICIO : La misma consulta, pero esta vez utilizando alias para las tablas involucradas.*/
	SELECT Tabla1.Nombre, Tabla1.Apellido, Tabla2.IDProyecto  
	FROM Empleadas AS Tabla1, EmpleadasEnProyectos AS Tabla2 
	WHERE Tabla1.IDEmpleada = Tabla2.IDEmpleada;

/*EJERCICIO : Selecciona los salarios medios de las empleadas asignadas al proyecto número 2 utilizando el producto cartesiano de las tablas Empleada y EmpleadasEnProyectos.*/
SELECT AVG(Empleadas.Salario), EmpleadasEnProyectos.IDProyecto  
FROM Empleadas, EmpleadasEnProyectos  
WHERE Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada AND EmpleadasEnProyectos.IDProyecto = 2  
GROUP BY EmpleadasEnProyectos.IDProyecto;


/*NATURAL JOIN */
/*De nuevo conocer los nombres y apellidos de las empleadas y a que proyectos pertenecen*/
SELECT Nombre, Apellido, IDProyecto   
FROM Empleadas NATURAL JOIN EmpleadasEnProyectos;  

/*EJERCICIO : Selecciona los salarios medios de las empleadas asignadas al proyecto número 2 realizando un NATURAL JOIN entre las tablas Empleada y EmpleadasEnProyectos.*/
SELECT AVG(Salario), IDProyecto  
FROM Empleadas NATURAL JOIN EmpleadasEnProyectos  
WHERE IDProyecto = 2  
GROUP BY IDProyecto;


/*INNER JOIN*/
/*EJEMPLO :Seleccionar el nombre y apellido de las empleadas y el proyecto al que están asociadas*/
SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto   
FROM Empleadas INNER JOIN EmpleadasEnProyectos  
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;  


/* EJERCICIO : Selecciona los salarios medios de las empleadas asignadas al proyecto número 2 realizando un INNER JOIN entre las tablas Empleada y EmpleadasEnProyectos. */
SELECT AVG(Empleadas.Salario), EmpleadasEnProyectos.IDProyecto  
FROM Empleadas INNER JOIN EmpleadasEnProyectos  
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada   
WHERE EmpleadasEnProyectos.IDProyecto = 2  
GROUP BY EmpleadasEnProyectos.IDProyecto;

/* EJERCICIO: Seleccionar el nombre y apellido de las empleadas y el proyecto al que están asociadas, pero con USING*/
SELECT Nombre, Apellido, EmpleadasEnProyectos.IDProyecto   
FROM Empleadas INNER JOIN EmpleadasEnProyectos  
USING (IDEmpleada);

/* EJERCICIO: Selecciona los salarios medios de las empleadas asignadas al proyecto número 2 realizando un INNER JOIN con USING entre las tablas Empleada y EmpleadasEnProyectos.*/
SELECT AVG(Empleadas.Salario), EmpleadasEnProyectos.IDProyecto  
FROM Empleadas INNER JOIN EmpleadasEnProyectos  
USING (IDEmpleada)     
WHERE EmpleadasEnProyectos.IDProyecto = 2  
GROUP BY EmpleadasEnProyectos.IDProyecto;


/**Ejercicios finales sobre tabla Customers y tabla Employees*/

USE tienda;

/*Ejercicio 1: Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas, usando CROSS JOIN*/
SELECT employees.employeeNumber, employees.firstName, employees.lastName, customers.customerNumber
FROM employees, customers
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber;

/*Ejercicio 2:Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando CROSS JOIN*/
SELECT employees.employeeNumber, employees.firstName, employees.lastName  
FROM employees, customers  
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber  
GROUP BY (employees.employeeNumber)  
HAVING COUNT(DISTINCT customers.customerNumber)>8;

/*Ejercicio 3: Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando CROSS JOIN */
SELECT employees.employeeNumber, employees.firstName, employees.lastName, COUNT(DISTINCT customers.country) AS PaisesClientes
FROM employees, customers  
WHERE employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY (employees.employeeNumber)
HAVING COUNT(DISTINCT customers.country)>1;


/*Ejercicio 4: Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas, usando INNER JOIN*/
SELECT employees.employeeNumber, employees.firstName, employees.lastName, customers.customerNumber  
FROM employees INNER JOIN customers  
ON employees.employeeNumber = customers.salesRepEmployeeNumber;

/*Ejercicio 5: Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando INNER JOIN:*/
SELECT employees.employeeNumber, employees.firstName, employees.lastName  
FROM employees INNER JOIN customers  
ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY (employees.employeeNumber)  
HAVING COUNT(DISTINCT customers.customerNumber)>8;

/*Ejercicio 6 Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando INNER JOIN*/
SELECT employees.employeeNumber, employees.firstName, employees.lastName, COUNT(DISTINCT customers.country) AS PaisesClientes
FROM employees INNER JOIN customers  
ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY (employees.employeeNumber)
HAVING COUNT(DISTINCT customers.country)>1;