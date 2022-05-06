

/*Ejercicio: Indica el orden de ejecución de la siguiente secuencia SQL,
 indicando las tablas-resultado que se van obteniendo tras cada paso.
La consulta a analizar es*/


SELECT Empleadas.IDEmpleada, Empleadas.Nombre, Empleadas.Apellido
FROM Empleadas JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada
GROUP BY (Empleadas.IDEmpleada)
HAVING COUNT(*)>1;

/* Primero se ejecutaría esta parte de la sentencia*/
SELECT Empleadas.IDEmpleada, Empleadas.Nombre, Empleadas.Apellido
FROM Empleadas JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada;

/* Tras esto se ejecutaría el GROUP BY*/

SELECT Empleadas.IDEmpleada, Empleadas.Nombre, Empleadas.Apellido
FROM Empleadas JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada
GROUP BY (Empleadas.IDEmpleada);


/*FINALMENTE SE EJECUTARÍA EL HAVING*/

SELECT Empleadas.IDEmpleada, Empleadas.Nombre, Empleadas.Apellido
FROM Empleadas JOIN EmpleadasEnProyectos
ON Empleadas.IDEmpleada = EmpleadasEnProyectos.IDEmpleada
GROUP BY (Empleadas.IDEmpleada)
HAVING COUNT(*)>1;


/*SUBCONSULTAS*/
/*EJEMPLO SUBCONSULTA: seleccionar el IDEmpleada y
 el Nombre de aquellas empleadas pertenecientes al proyecto con IDProyecto = 2/ */

SELECT IDEmpleada, Nombre
FROM Empleadas
WHERE IDEmpleada IN (SELECT IDEmpleada
FROM EmpleadasEnProyectos
WHERE IDProyecto=2);

/*EJEMPLO SUBCONSULTA con IN: seleccionar el IDEmpleada y
 el Nombre de aquellas empleadas pertenecientes al proyecto con IDProyecto*/

SELECT IDEmpleada, Nombre
FROM Empleadas
WHERE IDEmpleada IN (SELECT IDEmpleada
FROM EmpleadasEnProyectos);

/*EJEMPLO SUBCONSULTA con NOT IN: seleccionar el IDEmpleada y
 el Nombre de aquellas empleadasque no  pertenezcan a ningun con IDProyecto*/
SELECT IDEmpleada, Nombre  
FROM Empleadas                                                                    
WHERE IDEmpleada NOT IN (SELECT IDEmpleada  
FROM EmpleadasEnProyectos);



/*Ejercicio: Selecciona el nombre, apellido y salario de las empleadas asignadas a más de un proyecto:*/

SELECT Nombre, Apellido, Salario
FROM Empleadas
WHERE IDEmpleada IN (
SELECT IDEmpleada
FROM EmpleadasEnProyectos
GROUP BY IDEmpleada
HAVING COUNT(IDProyecto) >1
);




/*Uso de ANY, ALL y EXISTS en subconsultas:*/

/*EJEMPLO ANY seleccionar aquellas empleadas cuyo salario sea mayor que cualquiera de los salarios de las compañeras que trabajen en el mismo país*/

SELECT IDEmpleada, Nombre, Salario
FROM Empleadas A
WHERE A.Salario > ANY (SELECT Salario
FROM Empleadas B
WHERE B.Pais = A.Pais);



/*EJEMPLO ALL : el salario de cada empleada se comparará con el de todas las demás empleadas de su mismo país. Si su salario es mayor o igual al de todas las demás
 (es decir, si es la que más cobra) se seleccionará su registro.*/
SELECT IDEmpleada, Nombre, Salario
FROM Empleadas A                                          
WHERE A.Salario >= ALL (SELECT Salario
FROM Empleadas B
WHERE B.Pais = A.Pais);


/**Ejercicio:** En el WHERE de la anterior consulta hemos usado un >= y no un > "a secas" debido a que el salario de la empleada también
 se está comparando con el suyo propio. De no incluir el =, no se cumpliría la condición para ninguna de las empleadas.
 Otra solución podría consistir en añadir condiciones adicionales en el WHERE de la subconsulta. ¿Cómo lo harías?*/

SELECT IDEmpleada, Nombre, Salario
FROM Empleadas A                                       
WHERE A.Salario > ALL (SELECT Salario
FROM Empleadas B
WHERE B.Pais = A.Pais AND B.IDEmpleada <> A.IDEmpleada);



/* EJEMPLO EXISTS: Seleccionar los datos de aquellas empleadas que trabajan en algún país en el que haya más de una empleada (ellas mismas no cuentan debido a la condición B.IDEmpleada <> A.IDEmpleada)*/

SELECT IDEmpleada, Nombre, Salario
FROM Empleadas A
WHERE EXISTS (SELECT *
FROM Empleadas B
WHERE B.Pais = A.Pais AND B.IDEmpleada <> A.IDEmpleada);


/*Ejercicio: Vamos a realizar un ejercicio en el que usaremos consultas y subconsultas a diferentes niveles de anidamiento y con distintos operadores de condición. Volviendo a las tablas Empleadas y EmpleadasPorProyecto:*/

/*Calcula el numero de empleadas por cada proyecto:*/
SELECT COUNT(IDEmpleada) AS EmpleadasPorProyecto
FROM EmpleadasEnProyectos
GROUP BY IDProyecto;

/*Usando la consulta anterior como subconsulta, selecciona el IDProyecto del proyecto con el mayor numero de empleadas:*/
SELECT IDProyecto
FROM EmpleadasEnProyectos
GROUP BY IDProyecto
HAVING COUNT(IDEmpleada) >= ALL (
SELECT COUNT(IDEmpleada) AS EmpleadasPorProyecto
FROM EmpleadasEnProyectos
GROUP BY IDProyecto
);

/*Por último, usa todas las consultas anteriores para seleccionar el IDEmpleada, Nombre y Apellido de las empleadas asignadas al proyecto con mayor numero de empleadas:*/

SELECT IDEmpleada, Nombre, Apellido
FROM Empleadas
WHERE IDEmpleada IN (
SELECT IDEmpleada
FROM EmpleadasEnProyectos
WHERE IDProyecto = (
SELECT IDProyecto
FROM EmpleadasEnProyectos
GROUP BY IDProyecto
HAVING COUNT(IDEmpleada) >= ALL (
SELECT COUNT(IDEmpleada) AS EmpleadasPorProyecto
FROM EmpleadasEnProyectos
GROUP BY IDProyecto)
)
);

/*EJERCICIO FINAL*/

USE tienda;


/*EJERCICIO 1
Calcula el numero de clientes por cada ciudad:*/
SELECT COUNT(customerNumber) AS ClientasPorCiudad
FROM customers
GROUP BY city;

/*EJERCICIO 2
Usando la consulta anterior como subconsulta, selecciona la ciudad con el mayor numero de clientes:*/
SELECT city
FROM customers
GROUP BY city
HAVING COUNT(customerNumber) >= ALL (
SELECT COUNT(customerNumber) AS ClientasPorCiudad
FROM customers
GROUP BY city
);

/*EJERCICIO 3
Por último, usa todas las consultas anteriores para seleccionar el customerNumber, Nombre y Apellido de las clientas asignadas a la ciudad con mayor numero de clientas:*/
SELECT customerNumber, contactFirstName, contactLastName
FROM customers
WHERE customerNumber IN (
SELECT customerNumber
FROM customers
WHERE city IN (
SELECT city
FROM customers
GROUP BY city
HAVING COUNT(customerNumber) >= ALL (
SELECT COUNT(customerNumber) AS ClientasPorCiudad
FROM customers
GROUP BY city
)
)
);

