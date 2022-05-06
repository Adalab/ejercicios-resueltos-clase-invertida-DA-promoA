CREATE SCHEMA `leccion-11-sql` ;

USE `leccion-11-sql`;



CREATE TABLE Empleadas
(IDEmpleada INT NOT NULL AUTO_INCREMENT,
Salario FLOAT DEFAULT NULL,
Nombre VARCHAR(30) DEFAULT NULL,
Apellido VARCHAR(30) DEFAULT NULL,
Pais VARCHAR(10) DEFAULT NULL,
PRIMARY KEY (IDEmpleada)
);

INSERT INTO Empleadas
VALUE (1, 2500,"Ana","González","España"),
(2, 4000, "Maria","López", "España"),
(3, 3000, "Lucía","Ramos", "España"),
(4, 5000, "Elena","Bueno", "España"),
(5, 1500, "Rocío","García", "Francia");



CREATE TABLE EmpleadasEnProyectos
(IDEmpleada INT NOT NULL REFERENCES Empleadas(IDEmpleada),
IDProyecto INT NOT NULL,
PRIMARY KEY (IDEmpleada,IDProyecto)
);


INSERT INTO EmpleadasEnProyectos
VALUE (1, 1),
(1, 2),
(2, 1),
(3, 2),
(3, 3),
(3, 5),
(4, 2),
(5, 3);

/*EJEMPLO CTE*/

SELECT Pais, AVG(Salario) as salario_medio_pais
FROM Empleadas
GROUP BY Pais;

WITH salario_avg AS (
SELECT Pais, AVG(Salario) as salario_medio_pais
FROM Empleadas
GROUP BY Pais)
SELECT e.IDEmpleada, e.Nombre, e.Apellido, e. Pais, e.Salario, avg.salario_medio_pais
FROM Empleadas e
JOIN salario_avg avg
ON e.Pais = avg.Pais;

/*EJEMPLO CTE al comienzo de subconsultas dentro de otra consulta select*/




WITH salario_avg AS (  
SELECT Pais, AVG(Salario) as salario_avg_pais  
FROM Empleadas  
GROUP BY Pais)
SELECT e.IDEmpleada, e.Nombre, e.Apellido, e.Pais, e.Salario, avg.salario_avg_pais
FROM Empleadas e JOIN salario_avg avg
ON avg.Pais = e.Pais;

/* Continuacion del anterior ejemplo En este caso nosotras lo usaremos para comprobar por cada empleada si su salario
 es mayor que el salario medio de su pais. Luego agruparemos los resultados por país y haremos un recuento final*/
SELECT COUNT(IDEmpleada), Pais
FROM (WITH salario_avg AS (  
SELECT Pais, AVG(Salario) as salario_avg_pais  
FROM Empleadas  
GROUP BY Pais)
SELECT e.IDEmpleada, e.Nombre, e.Apellido, e.Pais, e.Salario as salario, avg.salario_avg_pais as salario_medio
FROM Empleadas e JOIN salario_avg avg
ON avg.Pais = e.Pais) as empleadas_salarios
WHERE empleadas_salarios.salario > empleadas_salarios.salario_medio
GROUP BY Pais;

/*EJEMPLO CTE justo antes del SELECT dentro de otras sentencias que contienen un SELECT*/
/*Ejemplo: Podemos crear una tabla que contenga el nombre de cada pais y el número de empleadas que cobran salarios por encima de la media de ese país.
 Es decir, el resultado del ejemplo anterior.*/



CREATE TABLE EmpleadasSalarioAlto
SELECT COUNT(IDEmpleada), Pais
FROM (WITH salario_avg AS (  
SELECT Pais, AVG(Salario) as salario_avg_pais  
FROM Empleadas  
GROUP BY Pais)
SELECT e.IDEmpleada, e.Nombre, e.Apellido, e.Pais, e.Salario as salario, avg.salario_avg_pais as salario_medio
FROM Empleadas e JOIN salario_avg avg
ON avg.Pais = e.Pais) as empleadas_salarios
WHERE empleadas_salarios.salario > empleadas_salarios.salario_medio
GROUP BY Pais;

SELECT *
FROM EmpleadasSalarioAlto;


/*EJEMPLO CTE RECURSIVA*/
WITH ContarFilas(NumeroFilas) AS  
(SELECT ROW_NUMBER() 
OVER(ORDER BY Nombre ASC) AS NumeroFilas2 
FROM Empleadas 
WHERE IDEmpleada <= 3) 
SELECT NumeroFilas 
FROM ContarFilas; 


/*EJERCICIO 1
Una serie de Fibonacci empieza con los números 0 y 1, y luego cada número en la serie se calcula como la suma como los dos números anteriores.
 Es decir, el tercer número sería 0 + 1 = 1, el cuarto sería 1 + 1 = 2, etc.
 Escribe una CTE recursiva que genere los 15 primeros números de la serie de Fibonacci.
 PISTA: tendrás que acceder solamente a los dos anteriores resultados de la serie de manera recursiva.*/

CREATE TABLE fibonacci
WITH RECURSIVE fibonacci (n, fib_n, next_fib_n) AS
(
SELECT 1, 0, 1
UNION ALL
SELECT n + 1, next_fib_n, fib_n + next_fib_n
FROM fibonacci
WHERE n < 15
)
SELECT * FROM fibonacci;


/*EJERCICIO 2
Suponiendo que el CTE para crear la serie de Fibonacci ya está definido (y se llama fibonacci),
 escribe una consulta SELECT que haciendo uso de dicha CTE seleccione sólo el séptimo elemento de la serie*/

SELECT fib_n
FROM fibonacci
WHERE n = 8;

/*EJERCICIO 3
Las CTE pueden ser útiles para para recorrer datos que siguen cierta jerarquía,
 como podría ser la cadena de supervisión dentro de una empresa.
 Imaginemos que en esa empresa cada empleada tiene una supervisora.
 Esa supervisora a su vez tiene una supervisora y así sucesivamente
 hasta llegar a la "cabeza" de la jerarquía, que podría ser la CEO de la empresa.
 La tabla empleadas que contiene esta información en la base de datos tendría el siguiente formato*/


CREATE TABLE Empleadas_camino
(id_empleada INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(30) DEFAULT NULL,
id_supervisora INT DEFAULT NULL,
PRIMARY KEY (id_empleada)
);

INSERT INTO Empleadas_camino
VALUE (29,'Pedro',	198),
(72,'Paco',	29),
(123,'Alba',	692),
(198,'Laura',	333),
(333,'Yasmina',	NULL),
(692,'Tomas',	333),
(4610,'Sara',	29);

CREATE TABLE camino_empleada
WITH RECURSIVE camino_empleada (id_empleada, nombre, camino) AS
(
SELECT id_empleada, nombre, CAST(id_empleada AS CHAR(200))
FROM Empleadas_camino
WHERE id_supervisora IS NULL
UNION ALL
SELECT e.id_empleada, e.nombre, CONCAT(ep.camino, ',', e.id_empleada)
FROM camino_empleada AS ep JOIN Empleadas_camino AS e
ON ep.id_empleada = e.id_supervisora
)
SELECT * FROM camino_empleada ORDER BY camino;