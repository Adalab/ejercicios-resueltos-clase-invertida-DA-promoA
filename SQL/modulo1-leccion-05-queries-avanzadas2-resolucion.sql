
 
/*EJEMPLO GROUP BY 1: seleccionar aquellas empleadas de cada Pais que tengan un salario alto (mayor a 3000€ mensuales)*/

SELECT COUNT(Salario) AS SalariosAltosPorPais, Pais
FROM Empleadas
WHERE Salario >= 3000
GROUP BY Pais;

/*EJEMPLO GROUP BY 2:  Calcula el salario medio por ciudad de las empleadas españolas*/


SELECT Ciudad, AVG(Salario) AS SalarioMedio
FROM Empleadas
WHERE Pais = "España"
GROUP BY Ciudad;
 
/*Ejercicio: ¿Cuantas empleadas hay en cada ciudad?*/

SELECT Ciudad, COUNT(Nombre) AS EmpleadasPorCiudad
FROM Empleadas
GROUP BY Ciudad;

/*EJEMPLO HAVING:  Obtener el salario medio de las empleadas para cada país, pero solo para los países que tengan al menos 3 empleadas:*/

SELECT AVG(Salario) AS SalariosMediosPais, Pais
FROM Empleadas
GROUP BY Pais
HAVING COUNT(*) >= 3;


/*Ejercicio: Trabajando de nuevo sobre la tabla Empleadas que hemos definido anteriormente,
 selecciona los nombres de las ciudades con una o más empleadas*/

SELECT Ciudad
FROM Empleadas
GROUP BY Ciudad
HAVING COUNT(*) >= 1;


/*EJEMPLO CASE WHEN 1 : Con 2 categorías*/

SELECT
CASE
WHEN Salario < 2000 THEN "Bajo"
ELSE "Alto"
END AS RangoSalario
FROM Empleadas;

/*EJEMPLO CASE WHEN 2: Con 3 categorías*/

SELECT
CASE WHEN Salario < 2000 THEN "Bajo"
WHEN Salario > 3000 THEN "Alto"
ELSE "Medio"
END AS RangoSalario, Salario
FROM Empleadas;

/*EJEMPLO CASE WHEN 3: Doble CASE WHEN*/
SELECT
CASE WHEN Salario < 2000 THEN "Bajo"
ELSE
CASE WHEN Salario > 3000 THEN "Alto"
ELSE "Medio"
END
END RangoSalario
FROM Empleadas;

/*EJEMPLO CASE WHEN 4: CASE dentro del WHERE*/

SELECT Nombre, Apellido
FROM Empleadas
WHERE Salario > (SELECT CASE WHEN Pais = "España" THEN 1000
WHEN Pais = "Francia" THEN 2000
ELSE 1500
END);


/* EJERCICIOS FINALES */

USE tienda;

/*EJERCICIO 1
Realiza una consulta SELECT que seleccione el número de cada empleado de ventas, así como el numero de clientes distintos que tiene cada uno:*/

SELECT salesRepEmployeeNumber AS NumEmpleado, COUNT(distinct customerNumber) AS NumClientes
FROM customers
GROUP BY(salesRepEmployeeNumber);

/*EJERCICIO 2
Selecciona el número de cada empleado de ventas que tenga más de 7 clientes distintos:*/

SELECT salesRepEmployeeNumber AS NumEmpleado, COUNT(distinct customerNumber) AS NumClientes
FROM customers
GROUP BY(salesRepEmployeeNumber)
HAVING COUNT(distinct customerNumber) > 7;

/*EJERCICIO 3
Selecciona el número de cada empleado de ventas, así como el numero de clientes distintos que tiene cada uno. 
Asigna una etiqueta de "AltoRendimiento" a aquellos empleados con mas de 7 clientes distintos*/

SELECT salesRepEmployeeNumber AS Empleado, COUNT(distinct customerNumber) AS NumClientes,
CASE WHEN COUNT(distinct customerNumber) > 7 THEN "AltoRendimiento" END AS Etiqueta
FROM customers
GROUP BY(salesRepEmployeeNumber);

/*EJERCICIO 4
Selecciona el número de clientes en cada pais*/

SELECT COUNT(customerNumber) AS NumClientes, country AS Pais
FROM customers
GROUP BY(country);

/*EJERCICIO 5
Selecciona aquellos paises que tienen clientes de más de 3 ciudades diferentes*/

SELECT country AS Pais, COUNT(distinct city)
 FROM customers
 GROUP BY(country)
 HAVING COUNT(distinct city) > 3;
