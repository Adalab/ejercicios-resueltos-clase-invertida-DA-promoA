  /*EJEMPLO Min*/
 
SELECT MIN(IDAlumna) AS IDMenor
FROM Alumnas;
 
/*Ejercicio: Selecciona el número de ID más alto de la tabla Alumnas y asignale un alias que sea explicativo.*/

SELECT MAX(IDAlumna) AS IDMayor
FROM Alumnas;


/*Ejercicio: Selecciona el último nombre de alumna si ordenasemos la columna en orden alfabético.*/

SELECT MAX(Nombre)
FROM Alumnas;


  /*EJEMPLO SUM : Calcular el salario total de la tabla Empleadas, con alias TotalSalarios*/
  
  SELECT SUM(Salario) AS TotalSalarios
FROM Empleadas;

 /*EJEMPLO AVG Calcular el salario medio de la tabla Empleadas con alias SalarioMedio*/
SELECT AVG(Salario) AS SalarioMedio
FROM Empleadas;

 /*EJEMPLO COUNT Mostar cuantas empleadas tienen un salario por encima de los 3000 euros */
 SELECT COUNT(Salario) AS SalariosAltos
FROM Empleadas
WHERE Salario >= 3000;


/*Ejercicios finales*/

USE tienda;

/*EJERCICIO 1
Realiza una consulta SELECT que obtenga el número identificativo de cliente más bajo de la base de datos.*/

SELECT MIN(customerNumber) AS NumeroMinimo
FROM customers;

/*EJERCICIO 2
Selecciona el limite de credito medio para los clientes de España(Spain):*/

SELECT AVG(creditLimit)
FROM customers
WHERE country = 'Spain';

/*EJERCICIO 3
Selecciona el numero de clientes en Francia(France):*/

SELECT COUNT(customerName)
FROM customers
WHERE country = 'France';

/*EJERCICIO 4
Selecciona el máximo de credito que tiene cualquiera de los clientes del empleado con número 1323:*/

SELECT MAX(creditLimit)
FROM customers
WHERE salesRepEmployeeNumber = 1323;

/*EJERCICIO 5
¿Cuál es el número máximo de empleado de la tabla Customers?*/

SELECT MAX(salesRepEmployeeNumber)
FROM customers;
