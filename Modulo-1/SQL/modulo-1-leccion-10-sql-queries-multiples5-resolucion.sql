


/*EJEMPLO : Deseamos conocer el ID de las empleadas, su nombre, apellidos y salario, así como las empleadas cuyo salarios sea superior o igual al salario medio de todas las empleadas de un mismo Pais.
Podríamos utilizar la siguente subconsulta correlacionada:*/

SELECT IDEmpleada, Nombre, Apellido, e1.Salario, e1.Pais
FROM Empleadas AS e1
WHERE e1.Salario >=
(SELECT avg(e2.Salario) 
FROM Empleadas AS e2
WHERE e1.Pais = e2.Pais)
ORDER BY Salario;

/* EJERCICIO/EJEMPLO */

/* Obtener todos los datos de aquellas filas que el nombre comience por A */
SELECT *
FROM Empleadas
WHERE nombre LIKE 'A%';

/* Obtener todos los datos de aquellas filas que el nombre termine por a */

SELECT *
FROM Empleadas
WHERE nombre LIKE '%a';

/* Obtener todos los datos de aquellas filas que el nombre contenga en algiuna posición un l */

SELECT *
FROM Empleadas
WHERE nombre LIKE '%l%';

/* Obtener todos los datos de aquellas filas que el nombre cuyo nombre contenga en la segunda posición una a */

SELECT *
FROM Empleadas
WHERE nombre LIKE '_a%' ;

/* Obtener todos los datos de aquellas filas de empleadas cuyo nombre empieza por 'e' y tiene una longitud de al menos 2 caracteres. */

SELECT *
FROM Empleadas
WHERE nombre LIKE 'e_%' ;


/* Obtener todos los datos de aquellas filas de empleadas cuyo nombre empieza por a y sea de longitud 3*/
SELECT *
FROM Empleadas
WHERE nombre LIKE 'a__' ;


/* Obtener todos los datos de aquellas filas de empleadas cuyo nombre empieza por a y termine en a*/

SELECT *
FROM Empleadas
WHERE nombre LIKE 'A%a' ;

/* Obtener todos los datos de aquellas filas de empleadas que empieza que no contengan en el nombre la letra l*/

SELECT *
FROM Empleadas
WHERE nombre NOT LIKE '%l%' ;


/*REGEX*/
/*EJEMPLO si quisieramos, de nuevo, volver a obtener los nombres de las empleadas que comienzan por 'A', podríamos hacer uso de la siguente instruccion*/


SELECT *
FROM Empleadas
WHERE nombre  REGEXP  '^A' ;


-- EJERCICIOS FINALES

USE tienda;

/*EJERCICIO 1 
Selecciona de la tabla products el productCode, productName, quantityInStock, productLine, MSRP, buyPrice,
 para aquellos casos en los que la diferencia entre el MSRP y el precio de compra sea mayor o igual a la media
 de la diferencia de precios entre MSRP y precio de compra con alias 'AvgProfit', siempre que el 'AvgProfit' sea superior a 50 euros.*/


SELECT p1.productCode, p1.productName, p1.quantityInStock, p1.productLine,p1.MSRP, p1.buyPrice, (p1.MSRP - p1.buyPrice) AS Earn
FROM products as p1
WHERE (p1.MSRP - p1.buyPrice ) >= 
(SELECT AVG(p2.MSRP - p2.buyPrice) as AvgProfit
FROM products as p2
WHERE p1.productCode = p2.productCode
HAVING AvgProfit >50);

/*EJERCICIO 2
Encuentra los campos customerName, city, de aquellas ciudades de la tabla de customers que terminen en 'on'.*/

SELECT customerName, city
FROM customers
WHERE city LIKE 'on';

/*EJERCICIO 3
Encuentra los campos customerName, city de aquellas ciudades de la tabla de customers que terminen en 'on' y que unicamente sean de longitud 4.*/



SELECT customerName, city
FROM customers
WHERE city LIKE '__on';

/*EJERCICIO 4
Encuentra el customerName, addressLine1 y city de aquellas ciudades que cotengan el número 3 en su direccion postal.*/
SELECT customerName,addressLine1, city
FROM customers
WHERE addressLine1 LIKE '%3%' AND city;


/*EJERCICIO 5
Encuentra el customerName, addressLine1 y city de aquellas ciudades que cotengan el número 3 en su direccion postal y la ciudad no empuiece por T.*/
SELECT customerName,addressLine1, city
FROM customers
WHERE addressLine1 LIKE '%3%' AND city not LIKE 'T%';


/*EJERCICIO 6
Selecciona, haciendo uso de expresiones regulares, los campos customerName, addressLine1 y city.
 Unicamente en el caso que la direccion postal, posea algun  número en dicho campo.*/
SELECT customerName,addressLine1, city, phone
FROM customers
WHERE addressLine1 REGEXP '[0-9]';

/*EJERCICIO 7
Investiga que ocurre al ejecutar la siguente sentencia sobre la tabla de products.

SELECT * FROM products
WHERE productDescription LIKE '%'%';


SELECT * FROM products
WHERE productDescription LIKE '%\'%';
*/



SELECT * FROM products
WHERE productDescription LIKE '%"%';



