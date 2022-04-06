# 14. Consultas de modificación 2


Ahora que ya tenemos soltura con algunas de las instrucciones de SQL para extraer algunos datos, vamos a proceder a ver que es lo que debemos hacer cuando queremos realizar alguna modificación sobre los datos contenidos en la base de datos con la que estamos trabajando. Ya sea porque hemos encontrado valores mal introducidos o erroneos, se nos ha proporcionado datos nuevos y han de ser introducidos en la base de datos o se nos ha pedido eliminar algún registro existente.

## INSERT

La instrucción INSERT se utiliza para introducir nuevos datos en una base de datos. Para ello es de vital importancia resaltar que se ha de especificar la tabla concreta en la que se quiera realizar la inserción de nuevos datos.

_INSERT INTO nombre\_tabla (columna1, columna2, columna3, columna4, ...)_ _VALUES (valor1, valor2, valor3, valor4, ....);_

Para hacer uso de esta intrucción se han de tener en cuenta un par de consideraciones previas a su uso y de importancia para poder ejecutarla correctamente.

1\. Sobre que tabla queremos realizar la insercción de nuevos datos.

2\. Las columnas que posee la tabla seleccionada.( La variable de ID, actua como clave primaria, no es necesario considerarla)

3\. Los tipos de datos contenido en cada columna de la tabla escogida. Esto se debe a que se ha tener en cuenta si estamos trabajando con texto, números o fechas.

* Los textos deben ser insertado entre comillas simples ' '. Los números de telefono se recomienda introducirlo como texto, ya que pueden incluir 0 delante o el prefijo que le corresponda.
* Los valores numéricos, los decimales siempre se indican con el separador **.** , en lugar de con la coma como estamos acostumbrados. Aquellos números que empiecen por 0, se descartará el 0 inicial, debido a que MySQL considera que no es relevante.
* Las fechas deben siempre introducirse en el formato **AAAA-MM-DD** (AÑO-MES-DIA), [notacion ISO 8601](https://es.wikipedia.org/wiki/ISO\_8601).

De nuevo consideremos la tabla Empleadas perteneciente a una compañía:

| IDEmpleada | Salario | Nombre | Apellido | Email           | Telefono  | Ciudad    | Pais    |
| ---------- | ------- | ------ | -------- | --------------- | --------- | --------- | ------- |
| 1          | 2500    | Ana    | González | ana@adalab.es   | 654785214 | Madrid    | España  |
| 2          | 4000    | Maria  | López    | maria@adalab.es | 689656322 | Barcelona | España  |
| 3          | 3000    | Lucía  | Ramos    | lucia@adalab.es | 674459123 | Valencia  | España  |
| 4          | 5000    | Elena  | Bueno    | elena@adalab.es | 628546577 | Bilbao    | España  |
| 5          | 1500    | Rocío  | García   | rocio@adalab.es | 616365624 | Paris     | Francia |

Si ahora se nos pidiera introducir un nuevo registro en la tabla deberíamos utilizar la instrucción INSERT, identificamos primero las consideraciones explicadas anteriormente antes de hacer uso de nueva la sentencia.

* La tabla sobre la que está trabajando es **Empleadas**
* La tabla contiene las columnas: **Salario**, **Nombre**, **Apellido**, **Email**, **Telefono**, **Ciudad**, **Pais**.
* Las columnas tienen los siguentes tipos de datos: **Numérico**, **Texto**, **Texto**, **Texto**, **Texto**, **Texto**, **Texto**.

Una vez conocido esto, procedemos a realizar la inserción de los datos de la siguente forma:

_INSERT INTO Empleadas (Salario, Nombre, Apellido, Email, Telefono, Ciudad, Pais)_\
_VALUES (2000, 'Inés', 'Romero', 'ines@adalab.es', '619739261', 'Sevilla', 'España');_

Tras ejecutar la sentencia anterior, la tabla se habrá actualizado y quedará de la siguente forma:

| IDEmpleada | Salario | Nombre | Apellido | Email           | Telefono  | Ciudad    | Pais    |
| ---------- | ------- | ------ | -------- | --------------- | --------- | --------- | ------- |
| 1          | 2500    | Ana    | González | ana@adalab.es   | 654785214 | Madrid    | España  |
| 2          | 4000    | Maria  | López    | maria@adalab.es | 689656322 | Barcelona | España  |
| 3          | 3000    | Lucía  | Ramos    | lucia@adalab.es | 674459123 | Valencia  | España  |
| 4          | 5000    | Elena  | Bueno    | elena@adalab.es | 628546577 | Bilbao    | España  |
| 5          | 1500    | Rocío  | García   | rocio@adalab.es | 616365624 | Paris     | Francia |
| 6          | 2000    | Inés   | Romero   | ines@adalab.es  | 619739261 | Sevilla   | España  |

Como podemos ver se habrá añadido un registro adicional, al final del último registo que existia previamente a la inserción. En el caso de que tuvieramos un valor a introducir y no conocieramos todos los campos requeridos, tampoco sería un problema. Dichos campos desconocidos se completarian con un **null**, sería un valor faltante.

Nos piden introducir los datos de la siguente empleada y se han olvidado de proporcionarnos los datos de email y cuidad. Podemos ver como quedaría la tabla Empleadas al insertar la nueva empleada en la tabla:

_INSERT INTO Empleadas (Salario, Nombre, Apellido, Email, Pais)_\
_VALUES (2200, 'Alba', 'Fernández', 'alba@adalab.es', 'Portugal');_

Tras correr la sentencia anterior, la tabla se habrá actualizado y quedará de la siguente forma:

| IDEmpleada | Salario | Nombre | Apellido  | Email           | Telefono  | Ciudad    | Pais    |
| ---------- | ------- | ------ | --------- | --------------- | --------- | --------- | ------- |
| 1          | 2500    | Ana    | González  | ana@adalab.es   | 654785214 | Madrid    | España  |
| 2          | 4000    | Maria  | López     | maria@adalab.es | 689656322 | Barcelona | España  |
| 3          | 3000    | Lucía  | Ramos     | lucia@adalab.es | 674459123 | Valencia  | España  |
| 4          | 5000    | Elena  | Bueno     | elena@adalab.es | 628546577 | Bilbao    | España  |
| 5          | 1500    | Rocío  | García    | rocio@adalab.es | 616365624 | Paris     | Francia |
| 6          | 2000    | Inés   | Romero    | ines@adalab.es  | 619739261 | Sevilla   | España  |
| 7          | 2200    | Alba   | Fernández | alba@adalab.es  | null      | null      | España  |

Así mismo, en caso de necesitar introducir más de un registro nuevo, se puede utilizar la sentencia INSERT, para realizarlo todo en una misma instancia, en lugar de tener que ir una por una. Para ello, lo ilustramos en el sienguente ejemplo.

Introduciremos ahora 3 nuevas empleadas a la tabla existente, para hacerlo es necesario poner una coma a continuación del siguente registro a introducir despues de los datos de cada nueva empleada:

_INSERT INTO Empleadas (Salario, Nombre, Apellido, Email,Telefono,Ciudad Pais)_\
_VALUES (1800, 'Julia', 'Aguilar', 'julia@adalab.es', '614339261', 'Zaragoza', 'España'),_\
_(2000, 'Irene', 'Montenegro', 'irene@adalab.es', '659745615', 'Cataluña', 'España'),_\
_(3000, 'Laura', 'Navarro', 'laura@adalab.es',NULL,NULL 'Italia'), ;_

La tabla resultante quedaría de las siguente forma:

| IDEmpleada | Salario | Nombre | Apellido   | Email           | Telefono  | Ciudad    | Pais    |
| ---------- | ------- | ------ | ---------- | --------------- | --------- | --------- | ------- |
| 1          | 2500    | Ana    | González   | ana@adalab.es   | 654785214 | Madrid    | España  |
| 2          | 4000    | Maria  | López      | maria@adalab.es | 689656322 | Barcelona | España  |
| 3          | 3000    | Lucía  | Ramos      | lucia@adalab.es | 674459123 | Valencia  | España  |
| 4          | 5000    | Elena  | Bueno      | elena@adalab.es | 628546577 | Bilbao    | España  |
| 5          | 1500    | Rocío  | García     | rocio@adalab.es | 616365624 | Paris     | Francia |
| 6          | 2000    | Inés   | Romero     | ines@adalab.es  | 619739261 | Sevilla   | España  |
| 7          | 2200    | Alba   | Fernández  | alba@adalab.es  | null      | null      | España  |
| 8          | 1800    | Julia  | Aguilar    | julia@adalab.es | 614339261 | Zaragoza  | España  |
| 9          | 2000    | Irene  | Montenegro | irene@adalab.es | 659745615 | Cataluña  | España  |
| 10         | 3000    | Laura  | Navarro    | laura@adalab.es | null      | null      | Italia  |

## UPDATE

La clausula UPDATE se utiliza para actualizar los datos existentes en algunos de los registros ya existentes de una tabla. Por ejemplo, en el caso de que se nos haya proporcionado información actualizada o se nos haya compartido algún campo que estuviera faltante para alguno de los registros.

De esta forma para utilizar esta instrucción debemos seguir la siguente sintanxis:

_UPDATE nombre\_tabla_\
_SET columna1 = valor1, columna2 = valor2, ...._\
_WHERE condicion= valor\_condición;_

```
NOTA: Hay que ser extremadamente cauteloso al actualizar registros en una tabla. Es muy importante fijarse
en la clausula WHERE en la instrucción UPDATE. WHERE indica los registros que deben ser actualizados. 
Si se omite esta clausula se actualizaran TODOS LOS REGISTROS DE LA TABLA!

Cosa que no queremos hacer nunca de los jamases, salvo que quieras ver el mundo arder
```

![This is fine](assets/images/1-14/fine.jpeg)

Vamos a ver un caso práctico haciendo uso de nuevo de la tabla de empleadas, tal y como la tenemos con los últimos registros introducidos en el apartado anterior. Imaginemos que ahora que la última empleada (Laura) se ha mudado a Madrid, en España y nos ha proporcionado un número de teléfono. Para introducir esta información haríamos uso de la instrucción INSERT, utilizando como condición en el WHERE el IDEmpleada, para únicamente actualizar ese registro. En los casos en los que se vaya a actualizar únicamente una de las filas de la tabla, se recomienda utilizar como condición el índice de la tabla asignado a dicho registro, para evitar actualizar más de un registro.

_UPDATE Empleadas_\
_SET Telefono = 678652840, Ciudad = Madrid, Pais = España_\
_WHERE IDEmpleada = 10;_

Tras ejecutar la sentencia anterior, la tabla de empleadas nos quedaría de la siguente manera:

| IDEmpleada | Salario | Nombre | Apellido   | Email           | Telefono  | Ciudad    | Pais    |
| ---------- | ------- | ------ | ---------- | --------------- | --------- | --------- | ------- |
| 1          | 2500    | Ana    | González   | ana@adalab.es   | 654785214 | Madrid    | España  |
| 2          | 4000    | Maria  | López      | maria@adalab.es | 689656322 | Barcelona | España  |
| 3          | 3000    | Lucía  | Ramos      | lucia@adalab.es | 674459123 | Valencia  | España  |
| 4          | 5000    | Elena  | Bueno      | elena@adalab.es | 628546577 | Bilbao    | España  |
| 5          | 1500    | Rocío  | García     | rocio@adalab.es | 616365624 | Paris     | Francia |
| 6          | 2000    | Inés   | Romero     | ines@adalab.es  | 619739261 | Sevilla   | España  |
| 7          | 2200    | Alba   | Fernández  | alba@adalab.es  | null      | null      | España  |
| 8          | 1800    | Julia  | Aguilar    | julia@adalab.es | 614339261 | Zaragoza  | España  |
| 9          | 2000    | Irene  | Montenegro | irene@adalab.es | 659745615 | Cataluña  | España  |
| 10         | 3000    | Laura  | Navarro    | laura@adalab.es | 678652840 | Madrid    | España  |

Si por algún error o por simple malicia, nos olvidásemos de la condicion de WHERE, habría ocurrido lo siguente:

_UPDATE Empleadas_\
_SET Telefono = 678652840, Ciudad = Madrid, Pais = España_

| IDEmpleada | Salario | Nombre | Apellido   | Email           | Telefono  | Ciudad | Pais   |
| ---------- | ------- | ------ | ---------- | --------------- | --------- | ------ | ------ |
| 1          | 2500    | Ana    | González   | ana@adalab.es   | 678652840 | Madrid | España |
| 2          | 4000    | Maria  | López      | maria@adalab.es | 678652840 | Madrid | España |
| 3          | 3000    | Lucía  | Ramos      | lucia@adalab.es | 678652840 | Madrid | España |
| 4          | 5000    | Elena  | Bueno      | elena@adalab.es | 678652840 | Madrid | España |
| 5          | 1500    | Rocío  | García     | rocio@adalab.es | 678652840 | Madrid | España |
| 6          | 2000    | Inés   | Romero     | ines@adalab.es  | 678652840 | Madrid | España |
| 7          | 2200    | Alba   | Fernández  | alba@adalab.es  | 678652840 | Madrid | España |
| 8          | 1800    | Julia  | Aguilar    | julia@adalab.es | 678652840 | Madrid | España |
| 9          | 2000    | Irene  | Montenegro | irene@adalab.es | 678652840 | Madrid | España |
| 10         | 3000    | Laura  | Navarro    | laura@adalab.es | 678652840 | Madrid | España |

En caso de que esto ocurriera, la única forma de solucionarlo sería utilizar una copia de seguridad anterior, para restaurar el estado de la tabla antes de la última instruccion de actualización de datos.

Imaginemos que hemos restaurado a la version anterior y hemos recuperado la tabla donde los datos de telefono y cuidad no son el mismo para todos los registros.

**NOTA: Por defecto MySQL workbench viene con el modo seguro activalo, lo que impide ejecutar secuencias de actualizacion o borrado de datos sin la condición WHERE, para evitar problemas actualizando datos.**

De forma opcional podemos incluir los siguentes campos, si por ejemplo queremos actulizar varias filas utilizando una condición común para una serie de filas de la tabla:

_UPDATE nombre\_tabla_\
_SET columna1 = valor1, columna2 = valor2, ...._\
_WHERE condiciones= valor\_condiciónes_\
_\[ORDER BY ...] (argumento opcional)_\
_\[LIMIT row\_count] (argumento opcional);_

Imaginemos ahora que han subido el salario mínimo interprofesional a 2000 euros. De estar forma tendríamos que actualizar algunos de los sueldos de la tabla de Empleadas, de esta forma podríamos hacer esto utilizando como condición el valor de la columna salarios.

De esta forma podríamos realizar lo anterior ahciendo uso de la siguente instrucción:

_UPDATE Empleadas_\
_SET Salario = 2000_\
_WHERE Salario <2000;_

De esta forma la tabla anterior nos cambiría 2 de los registros de la tabla nos quedaría de la siguente forma:

| IDEmpleada | Salario | Nombre | Apellido   | Email           | Telefono  | Ciudad    | Pais    |
| ---------- | ------- | ------ | ---------- | --------------- | --------- | --------- | ------- |
| 1          | 2500    | Ana    | González   | ana@adalab.es   | 654785214 | Madrid    | España  |
| 2          | 4000    | Maria  | López      | maria@adalab.es | 689656322 | Barcelona | España  |
| 3          | 3000    | Lucía  | Ramos      | lucia@adalab.es | 674459123 | Valencia  | España  |
| 4          | 5000    | Elena  | Bueno      | elena@adalab.es | 628546577 | Bilbao    | España  |
| 5          | 2000    | Rocío  | García     | rocio@adalab.es | 616365624 | Paris     | Francia |
| 6          | 2000    | Inés   | Romero     | ines@adalab.es  | 619739261 | Sevilla   | España  |
| 7          | 2200    | Alba   | Fernández  | alba@adalab.es  | null      | null      | España  |
| 8          | 2000    | Julia  | Aguilar    | julia@adalab.es | 614339261 | Zaragoza  | España  |
| 9          | 2000    | Irene  | Montenegro | irene@adalab.es | 659745615 | Cataluña  | España  |
| 10         | 3000    | Laura  | Navarro    | laura@adalab.es | 678652840 | Madrid    | España  |

\*\*NOTA: Es posible que con el modo seguro, tampoco permita actualizar más de un registro, basado en una condición. Más vale ser precavido, que acabar rompiendo las tablas! \*\*

## DELETE

La instrucción DELETE se utiliza de forma similar al explicado en el apartado anterior. En este caso su ejecución elimina una o varias de las filas de la tabla. Esto es útil cuando deseamos quitar registros de una tabla. La sintaxis a emplear para hacer uso de esta instruccción es las siguente:

_DELETE FROM Empleadas_\
_WHERE condición = valor\_condición_

De forma opcional podemos incluir los siguentes campos, si por ejemplo queremos actulizar varias filas utilizando una condición común para una serie de filas de la tabla:

_DELETE FROM nombre\_tabla_\
_WHERE condiciones= valor\_condiciónes_\
_\[ORDER BY ...] (argumento opcional)_\
_\[LIMIT row\_count] (argumento opcional);_

```
NOTA: Hay que ser extremadamente cauteloso al actualizar registros en una tabla. Es muy importante fijarse
en la clausula WHERE en la instrucción DELETE. WHERE indica los registros que deben ser actualizados. 
Si se omite esta clausula se actualizaran TODOS LOS REGISTROS DE LA TABLA!
```

Vamos a ver ahora un ejemplo sencillo del uso de esta nueva instruccion haciendo uso de nuevo de nuestra tabla de Empleadas. Para ello imaginemos que una de las empleadas ha dejado la empresa y nos han pedido que eliminemos su registro de la base de datos. Concretamente tenemos que eliminar los datos pertenecientes a Julia Aguilar. De esta forma tendríamos que ejecutar la siguente instrucción.

_DELETE FROM Empleadas_\
_WHERE IDEmpleada = 8_

| IDEmpleada | Salario | Nombre | Apellido   | Email           | Telefono  | Ciudad    | Pais    |
| ---------- | ------- | ------ | ---------- | --------------- | --------- | --------- | ------- |
| 1          | 2500    | Ana    | González   | ana@adalab.es   | 654785214 | Madrid    | España  |
| 2          | 4000    | Maria  | López      | maria@adalab.es | 689656322 | Barcelona | España  |
| 3          | 3000    | Lucía  | Ramos      | lucia@adalab.es | 674459123 | Valencia  | España  |
| 4          | 5000    | Elena  | Bueno      | elena@adalab.es | 628546577 | Bilbao    | España  |
| 5          | 2000    | Rocío  | García     | rocio@adalab.es | 616365624 | Paris     | Francia |
| 6          | 2000    | Inés   | Romero     | ines@adalab.es  | 619739261 | Sevilla   | España  |
| 7          | 2200    | Alba   | Fernández  | alba@adalab.es  | null      | null      | España  |
| 9          | 2000    | Irene  | Montenegro | irene@adalab.es | 659745615 | Cataluña  | España  |
| 10         | 3000    | Laura  | Navarro    | laura@adalab.es | 678652840 | Madrid    | España  |

Alternativamente podríamos haber eliminado en campo sin hacer uso del IDEmpleada, utilizando más de una condición para conseguir el mismo resultado:

_DELETE FROM Empleadas_\
_WHERE Nombre = 'Julia' AND Apellido= 'Aguilar';_

Vamos ahora a ver como podríamos eliminar más de una fila haciendo uso de una única condición. Por ejemplo supongamos que ahora se ha puesto un tope al salario máximo de las empleadas y todas menos una de las empleadas que cobran más de 2500 euros han decidido dejar la empresa. De esta forma necesitaremos eliminar diversos registros. Por tanto podemos hacer uso de la siguente instrucción para hacerlo de una vez.

_DELETE FROM Empleadas_\
_WHERE Salario > 2500_\
_ORDER BY Salario DESC_\
_LIMIT 3;_

Al ejecutar la sentencia la tabla anterior nos quedaría de la siguente forma:

| IDEmpleada | Salario | Nombre | Apellido   | Email           | Telefono  | Ciudad   | Pais    |
| ---------- | ------- | ------ | ---------- | --------------- | --------- | -------- | ------- |
| 1          | 2500    | Ana    | González   | ana@adalab.es   | 654785214 | Madrid   | España  |
| 3          | 3000    | Lucía  | Ramos      | lucia@adalab.es | 674459123 | Valencia | España  |
| 5          | 2000    | Rocío  | García     | rocio@adalab.es | 616365624 | Paris    | Francia |
| 6          | 2000    | Inés   | Romero     | ines@adalab.es  | 619739261 | Sevilla  | España  |
| 7          | 2200    | Alba   | Fernández  | alba@adalab.es  | null      | null     | España  |
| 9          | 2000    | Irene  | Montenegro | irene@adalab.es | 659745615 | Cataluña | España  |

Se ha empleado el salario como forma de ordenar la tabla, ya que teniamos 4 empleadas que cobraban más de 2500 euros, pero una de ellas ha decidido quedarse en la empresa.

Finalmente vamos a ver que pasaría, si nos olvidásemos de incluir la condición a la hora de realizar la elimacnion de registros. Esto causaría que se eliminaran todos los registros de la tabla de empleadas, sin eliminar la tabla en si.

_DELETE FROM Empleadas_;

**NOTA: De nuevo el modo seguro de MySQL workbench, nos impide ejecutar esta sentencia, ya que en los casos habituales de uso NUNCA desearemos dejar una tabla vacia.**

La tabla resultante sería la siguente:

La tabla se habria quedado compleatamente vacía. De ahí la precaución que se ha de tomar a la hora de eliminar valores de las tablas, para no terminar cargandose tablas enteras por error.

ENUNCIADO EJERCICIOS En este ejercicio vamos a usar una tabla ya creada llamada Customers (Clientes/as) que vamos a importar en MySQL Workbench. Si tienes dudas de como importarla, revisita la página asociada de tutorial. Esta tabla ya ha sido importada en otra lección, pero vamos a importarla de nuevo con otro nombre, debido a que vamos a realizar modificaciones muy considerables sobre los datos que contienen.

a tabla Customers tiene las siguientes columnas:

**Customers**(`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, `phone`, `addressLine1`, `addressLine2`, `city`, `state`, `postalCode`, `country`, `salesRepEmployeeNumber`, `creditLimit`)

Cada columna es bastante autodescriptiva en su nombre, pero vamos a incluir una pequeña descripción:

* _customerNumber_: el número identificativo de las clientas/es. Es un número entero y sirve de clave primaria.
* _customerName_: el nombre de las empresas en las que trabajan las/los clientas/es. Es una cadena de texto.
* _contactLastName_: El apellido de la persona de contacto en la empresa cliente. Es una cadena de texto.
* _contactFirstName_: El nombre de la persona de contacto en la empresa cliente. Es una cadena de texto.
* _phone_: El teléfono de la persona de contacto en la empresa cliente. Es una cadena de texto (ya que hay espacios).
* _adressLine1_: La dirección (calle, número, etc.) de la empresa cliente. Es una cadena de texto.
* _adressLine2_: La dirección de la empresa cliente (si se necesita mas espacio). Es una cadena de texto. Muchas veces está vacía.
* _city_: La ciudad de la empresa cliente.
* _state_: El estado en el que se encuentra la empresa cliente. Válido para los Estados Unidos. Es una cadena de texto.
* _postalCode_: El código postal. Es una cadena de texto (ya que puede haber espacios).
* _country_: El país de la empresa cliente. Es una cadena de texto.
* _salesRepEmployeeNumber_: El número identificador de la empleada o empleado que lleva a esa empresa cliente. Es un número entero.
* _creditLimit_: El límite de crédito que tiene la empresa cliente.

La tabla Employees tiene las siguientes columnas:

* _employeeNumber_: el número identificativo de las empleadas/os. Es un número entero y sirve de clave primaria.
* _lastName_: el apellido de las empleadas. Es una cadena de texto.
* _firstName_: el nombre de las empleadas. Es una cadena de texto.
* _extension_: su extensión telefónica. Es una cadena de texto.
* _email_: el correo electrónico de la empleada. Es una cadena de texto.
* _officeCode_: El código de la oficina de la empleada. Es una cadena de texto.
* _reportsTo_: el número identificativo de la empleada a la que reporta (su supervisora). Es un número entero y clave foránea (relacionada con employeeNumber).
* _jobTitle_: el nombre del puesto de trabajo que desempeña. Es una cadena de texto.

#### EJERCICIO 0

Piensa en la información que puede contener cada columna y el tipo de datos que puede contener. Incluye esta información en forma de comentario, sobre tu script de sql.

Recordatorio: Los comentarios se introducen utilizando /\* texto\_del\_comentario /\*

#### EJERCICIO 1

Crea una copia de la tabla Customers, ya que vamos a modificar los datos originales de dicha tabla. Para ello ejecuta la siguente sentencia:

CREATE TABLE IF NOT EXISTS customers\_mod SELECT \* FROM customers;

Así mismo vamos a desactivar el modo seguro para poder realizar los ejercicos posteriores. Para ello: Pestaña Editar -> Preferencias -> Editor SQL -> Deseleccionar la opcion de Actualizaciones segura (rechaza UPDATEs y DELETEs sin restricciones) -> Desconectate del servidor y vuelve a conectarte o alternativamente cierra MySQL y vuelve a abrirlo.

#### EJERCICIO 2

Realiza una inserción de datos sobre la tabla Customers introduciendo la siguente información.

* customerNumber: 343
* customerName: Adalab
* contactLastName: Rodriguez
* contactFirstName: Julia
* phone: 672986373
* addressLine1: Calle Falsa 123
* addressLine2: Puerta 42
* city: Madrid
* state: España
* postalCode:28000
* country: España
* salesRepEmployeeNumber: 15
* creditLimit: 20000000

#### EJERCICIO 3

Realiza una inserción de datos sobre la tabla Customers introduciendo la siguente información. Fijate que ahora no tenemos toda la información.

* customerNumber: 344
* customerName: La pegatina After
* contactLastName: Santiago
* contactFirstName: Maricarmen
* phone: 00000000
* addressLine1: Travesia del rave
* addressLine2: NULL
* city: Palma de mallorca
* state: NULL
* postalCode:07005
* country: España
* salesRepEmployeeNumber: 10
* creditLimit: 45673453

#### EJERCICIO 4

Introduce ahora 5 filas nuevas con la información que consideres relevante para los campos disponibles ( Se recuerda que el Indice(la clave primaria), no es necesaria especificarla) en una misma instrucción. En 3 de las nuevas filas debes dejar vacio el campo 'contactFirstName'

#### EJERCICIO 5

Actualiza ahora los datos faltantes corresponentes al CustomerName 'La pegatina After's' con la siguente información.

* addressLine1: Poligono Industrial de Son Castelló
* addressLine2: Nave 92
* city: Palma de mallorca
* state: España
* postalCode:28123
* country: España
* salesRepEmployeeNumber: 25
* creditLimit: 5000000

#### EJERCICIO 6

Vamos ahora a romper a proposito la tabla con la que estamos trabajando, para ello primero vamos a realizar una copia de la misma antes de ejecutar lo siguiente. Con el nombre customers\_destroy.

Para ello hacemos uso de la herramienta de exportacion de datos de MySQL, como se explicaba en las guías del módulo 0 para la exportacion y la importación de datos.

Una vez creada la copia y guardada a buen recaudo. Vamos a actualizar algunos de los cambios sin especificar la condición del WHERE. Para ello modifica el campo los siguentes campos de

* adressLine1: Vamos
* adressLine2: a
* postalCode: fastidiar
* country: la tabla :)

Y observa los frutos de de tu metedura de pata.

Tras esto restaura la tabla que has trasteado con la copia que te has creado previamente.

#### EJERCICIO 7

Actaliza ahora los datos de la tabla customers\_mod, para que las 10 primeras empresas sean gestionadas por la repesentante de ventas numero 2. El resto de empresas no deben ser modificadas.

#### EJERCICIO 8

Queremos ahora eliminar de los datos de la tabla aquellos registros que contentan un 'null' en el campo 'ContactFirstName'

#### EJERCICIO 9

Eliminar ahora de los datos de la tabla aquellos los últimos 5 registros de la tabla ordenando por la columna creditLimit en order de mayor a menor, queremos eliminar las 5 empresas con menor liquidez.

#### EJERCICIO 10

Ejecuta la instruccion de DELETE para la tabla customers\_mod olvidando el WHERE como condición. Y observa lo que ha ocurrido. ( Y medita sobre las decisiones que has tomado en tu vida, si esto ocurriera en la base de datos de la empresa en la que trabajases, como mínimo te caería una bronca de narices)

#### EJERCICIO 11

Con el fin de que no se vuelva a repetir el ejecutar la sentencia DELETE sin el WHERE, mira el siguente vídeo

[No te olvides de poner el Where en el Delete From.](https://www.youtube.com/watch?v=i\_cVJgIz\_Cs)


<!---
## Repaso

En esta lección hemos complementado los conocimientos básicos de SQL aprendiendo a usar otros operadores e instrucciones más avanzadas:

* INSERT: Se utiliza para introducir nuevos valores dentro de la tabla seleccionada, si se deja algún campo vacío del total de columnas, se introduce un null por defecto.
* UPDATE: Se utiliza para reescribir los valores existentes de una columna por unos nuevos valores, es importante utilizar el WHERE con una condición, para solo actualizar los valores deseados. Si se omite, actualizará todos los valores de dicha columna para la totalidad de la tabla.
* DELETE: Se utiliza para eliminar filas de la tabla. Es imprescindible de nuevo utilizar el WHERE con una condición, para eliminar únicamente los valores deseados. Si se omite, se eliminará todo el contenido de la tabla.

--->
