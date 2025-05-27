--Consulta 2
--Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
SELECT  "title"
FROM "film" f
WHERE "rating" = 'R';

--Consulta 3
--Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
SELECT "first_name", "last_name"
FROM "actor" a
WHERE "actor_id" >30
AND "actor_id" <40;

--Consulta 4
--Obtén las películas cuyo idioma coincide con el idioma original.
SELECT "title"
FROM "film" f
WHERE  "language_id" = "original_language_id";
--Consulta 5
--Ordena las películas por duración de forma ascendente.
SELECT "title", "length"
FROM "film" f
ORDER BY "length" ASC;

--Consulta 6
--Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
SELECT "last_name", "first_name"
FROM "actor" a
WHERE "last_name" LIKE 'ALLEN';

--Consulta 7
/*Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra 
la clasificación junto con el recuento.*/
SELECT "category_id" AS "category", COUNT("film_id")
FROM "film_category" fc
GROUP BY "category_id"
ORDER BY "category_id" ASC;

--Consulta 8 
/*Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas 
en la tabla film.*/
SELECT "title" AS "titulo", "length" AS "duración", "rating"
FROM "film" f
WHERE "rating" = 'PG-13'
 OR "length" > 180;

--Consulta 9 
--Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT STDDEV("replacement_cost"), VARIANCE("replacement_cost")
FROM "film" f;

--Consulta 10 
--Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT "title", "length"
FROM "film" f
WHERE 
"length" = (
 SELECT MIN("length") 
 FROM "film" f2)
OR "length" = (
 SELECT MAX("length") 
 FROM "film" f2)
ORDER BY "length";

--Consulta 11
--Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT r."rental_id", "rental_date", "amount", p."rental_id"
FROM "rental" r
INNER JOIN  "payment" p ON r."rental_id" = p."rental_id"
ORDER BY "rental_date" desc
LIMIT 1 OFFSET 2;

--Consulta 12
/*Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC 17’ ni ‘G’ en cuanto a su 
 clasificación.*/
SELECT "title" AS "titulo", "rating" AS "clasificación"
FROM "film" f
WHERE "rating" <> 'NC-17'
AND "rating" <> 'G';

--Consulta 13
/*Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra 
 la clasificación junto con el promedio de duración.*/
SELECT AVG("length") AS "duración_promedio", "rating" AS "clasificación"
FROM "film" f
GROUP BY "rating"
ORDER BY AVG("length") ASC;

--Consulta 14
--Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT "title", "length"
FROM "film" f
WHERE "length" > 180;

--Consulta 15
--¿Cuánto dinero ha generado en total la empresa? 
SELECT SUM("amount")
FROM "payment" p

--Consulta 16 
--Muestra los 10 clientes con mayor valor de id. 
SELECT "customer_id"
FROM "customer" c
ORDER BY "customer_id" DESC
LIMIT 10;

--Consulta 17 
--Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’
SELECT a."actor_id", fa."actor_id", "first_name" AS "Nombre", "last_name" AS "Apellido", fa."film_id", f."film_id"
FROM "actor" a
LEFT JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
INNER JOIN "film" f ON fa."film_id" = f."film_id"
WHERE "title" = 'EGG IGBY'

--Consulta 18 
--Selecciona todos los nombres de las películas únicas. 
SELECT "title"
FROM "film" f
GROUP BY "title"
HAVING COUNT ("title") = 1
ORDER BY "title" ASC;

--Consulta 19 
/*Encuentra el título de las películas que son comedias y tienen una duración mayor a 
180 minutos en la tabla “film”.*/
SELECT "title", "length" AS duración, "name"
FROM "film" f
INNER JOIN  "film_category" fc ON f."film_id" = fc."film_id"
FULL JOIN "category" c ON fc."category_id" = c."category_id"
WHERE "length" > 180
 AND c."name" = 'Comedy';

--Consulta 20
/*Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y 
muestra el nombre de la categoría junto con el promedio de duración. */
SELECT "name" AS "Categoría", AVG("length") AS "promedio duración"
FROM "film" f
INNER JOIN "film_category" fc ON f."film_id" = fc."film_id"
FULL JOIN "category" c ON fc."category_id" = c."category_id"
GROUP BY "name"
HAVING AVG("length") > 110;

--Consulta 21
--¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(r."return_date" - r."rental_date") AS "Promedio"
FROM rental r;
/*De esta forma conseguríamos el promedio de la duración de los alquileres pero el resultado muestra un valor imposible
*por lo que vamos a reducir al cálculo del promedio de los días de alquiler solo*/
SELECT AVG((r."return_date"::DATE)-(r."rental_date"::DATE)) AS "promedio_días"
FROM rental r;

--Consulta 22
--Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT CONCAT("first_name",' ', "last_name")
FROM "actor" a;

--Consulta 23
--Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT DATE("rental_date") AS "fecha", COUNT("rental_id") AS "cantidad de alquileres"
FROM "rental" r
GROUP BY DATE("rental_date")
ORDER BY COUNT("rental_id") DESC;

--Consulta 24
--Encuentra las películas con una duración superior al promedio. 
WITH promedio_duracion AS(
SELECT AVG("length") AS "promedio"
FROM "film" f)
SELECT "title", "length" AS "duración"
FROM "film" f
WHERE "length" > (
SELECT "promedio" 
FROM promedio_duracion);

--Consulta 25
--Averigua el número de alquileres registrados por mes.
SELECT COUNT("rental_id"), TO_CHAR("rental_date", 'YYYY-MM') AS "Meses de alquiler"
FROM "rental" r
GROUP BY TO_CHAR("rental_date", 'YYYY-MM')
ORDER BY TO_CHAR("rental_date", 'YYYY-MM') ASC;

--Consulta 26 
--Encuentra el promedio, la desviación estándar y la varianza del total pagado.
SELECT SUM("amount") AS "total pagado", AVG("amount") AS "promedio", STDDEV("amount") AS "desviación std", VARIANCE("amount")AS "varianza"
FROM "payment" p;

--Consulta 27 
--¿Qué películas se alquilan por encima del precio medio?
SELECT "title", "rental_rate"
FROM "film" f
WHERE "rental_rate" > (
SELECT AVG("rental_rate")
FROM "film" f2);

--Consulta 28 
--Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT CONCAT("first_name", ' ', "last_name") AS "nombre", a."actor_id", COUNT(fa."film_id")
FROM "actor" a
INNER JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
GROUP BY a."first_name", a."last_name", a."actor_id"
HAVING COUNT(fa."film_id") > 40;

--Consulta 29
--Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible. 
SELECT "title", f."film_id", COUNT(i."inventory_id") AS "cantidad_disponible"
FROM "film" f
LEFT JOIN "inventory" i ON f."film_id" = i."film_id"
GROUP BY f."title", f."film_id";

--Consulta 30 
--Obtener los actores y el número de películas en las que han participado.
SELECT CONCAT("first_name", ' ', "last_name") AS "nombre", COUNT("film_id") 
FROM "actor" a
RIGHT JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
GROUP BY a."first_name", a."actor_id", a."last_name";

--Consulta 31
/*Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas 
no tienen actores asociados.*/
SELECT "title", CONCAT("first_name", ' ', "last_name") AS "nombre"
FROM "film" f
LEFT JOIN "film_actor" fa ON f."film_id" = fa."film_id"
LEFT JOIN "actor" a ON fa."actor_id" = a."actor_id"
ORDER BY "title";

--Consulta 32
/*Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos 
actores no han actuado en ninguna película.*/
SELECT "title", CONCAT("first_name", ' ', "last_name") AS "Actor"
FROM "actor" a
LEFT JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
LEFT JOIN "film" f ON fa."film_id" = f."film_id"
ORDER BY a."first_name", a."last_name";

--Consulta 33
--Obtener todas las películas que tenemos y todos los registros de alquiler. 
SELECT "title", "rental_id"
FROM "film" f
LEFT JOIN "inventory" i ON f."film_id" = i."film_id"
INNER JOIN "rental" r ON i."inventory_id" = r."inventory_id"
ORDER BY "title";

--Consulta 34
--Encuentra los 5 clientes que más dinero se hayan gastado con nosotros. 
SELECT SUM("amount"), CONCAT("first_name", ' ', "last_name") AS "cliente"
FROM "payment" p
FULL JOIN "rental" r ON p."rental_id" = r."rental_id"
LEFT JOIN "customer" c ON r."customer_id" = c."customer_id"
GROUP BY CONCAT("first_name", ' ', "last_name")
ORDER BY SUM("amount") DESC
LIMIT 5;

--Consulta 35
--Selecciona todos los actores cuyo primer nombre es 'Johnny'
SELECT "first_name", "last_name"
FROM "actor" a
WHERE "first_name" = 'JOHNNY';

--Consulta 36 
--Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
SELECT "first_name" AS "Nombre", "last_name" AS "Apellido"
FROM actor a;

--Consulta 37 
--Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT CONCAT("first_name", ' ', "last_name"), "actor_id"
FROM "actor" a
WHERE "actor_id" = (
SELECT MIN("actor_id")
FROM "actor" a2)
OR "actor_id" = (
SELECT MAX("actor_id")
FROM "actor" a2);

--Consulta 38 
--Cuenta cuántos actores hay en la tabla “actor”. 
SELECT COUNT(DISTINCT(CONCAT("first_name", ' ', "last_name")))
FROM "actor" a;

--Consulta 39 
--Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT DISTINCT "first_name", "last_name"
FROM "actor" a
ORDER BY "last_name" ASC;

--Consulta 40
--Selecciona las primeras 5 películas de la tabla “film”.
SELECT "title"
FROM "film" f
LIMIT 5

--Consulta 41
/*Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. 
¿Cuál es el nombre más repetido?*/
SELECT COUNT("first_name") AS "Nombre repetido", "first_name"
FROM "actor" a
GROUP BY "first_name"
ORDER BY COUNT("first_name") DESC;

--Consulta 42
--Encuentra todos los alquileres y los nombres de los clientes que los realizaron. 
SELECT CONCAT("first_name", ' ', "last_name") AS "cliente", "rental_id", r."rental_date"
FROM "rental" r
LEFT JOIN "customer" c ON c."customer_id" = r."customer_id"
ORDER BY CONCAT("first_name", ' ', "last_name");

--Consulta 43
--Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres. 
SELECT CONCAT("first_name", ' ', "last_name") AS "cliente", "rental_id", r."rental_date"
FROM "customer" c
LEFT JOIN "rental" r ON c."customer_id" = r."customer_id"
ORDER BY CONCAT("first_name", ' ', "last_name");

--Consulta 44
/*Realiza un CROSS JOIN entre las tablas film y category. 
¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/
SELECT *
FROM "film" f
CROSS JOIN "category" c;
/*Realizar este cross join no solo no aporta valor si no que además genera confusión ya que al devolver el 
 producto cartesiano de las dos tablas cada película pasa a tener 16 categorías desfasando la calidad y la 
 veracidad del dato. Para que la unión de estas tablas aportara valor de verdad el join debería crearse así: */
SELECT "title", "description", "rental_rate", "rating", c."category_id", "name"
FROM "film" f
LEFT JOIN "film_category" fc ON f."film_id" = fc."film_id"
INNER JOIN "category" c ON fc."category_id" = c."category_id";

--Consulta 45
--Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT DISTINCT a."first_name", a."last_name", c."name", fc."category_id"
FROM "actor" a
INNER JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
INNER JOIN "film" f ON fa."film_id" = f."film_id"
INNER JOIN "film_category" fc ON f."film_id" = fc."film_id"
INNER JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Action'
ORDER BY a."first_name", a."last_name";

--Consulta 46
--Encuentra todos los actores que no han participado en películas.
SELECT "first_name", "last_name", a."actor_id", fa."film_id"
FROM "actor" a
RIGHT JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
WHERE fa."film_id" IS NULL;

--Consulta 47
--Selecciona el nombre de los actores y la cantidad de películas en las que han participado. 
SELECT COUNT("film_id") AS "Nº peliculas", CONCAT("first_name", ' ', "last_name") AS "Actor"
FROM "film_actor" fa
LEFT JOIN "actor" a ON fa."actor_id" = a."actor_id"
GROUP BY CONCAT("first_name", ' ', "last_name")
ORDER BY COUNT("film_id") DESC;

--Consulta 48 
/*Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y
 el número de películas en las que han participado.*/
CREATE VIEW "actor_num_peliculas" AS
SELECT  COUNT("film_id") AS "Nº peliculas", CONCAT("first_name", ' ', "last_name") AS "Actor"
FROM "film_actor" fa
LEFT JOIN "actor" a ON fa."actor_id" = a."actor_id"
GROUP BY CONCAT("first_name", ' ', "last_name")
ORDER BY COUNT("film_id") DESC;

--Consulta 49
--Calcula el número total de alquileres por cada cliente
SELECT COUNT("rental_id"), c."customer_id",CONCAT(c."first_name", ' ', c."last_name")
FROM "rental" r
INNER JOIN "customer" c ON r."customer_id" = c."customer_id"
GROUP BY c."customer_id"
ORDER BY COUNT("rental_id") DESC;

--Consulta 50 
--Calcula la duración total de las películas en la categoría 'Action'.
SELECT SUM(f."length"), c."category_id", c."name"
FROM "film" f
LEFT JOIN "film_category" fc ON f."film_id" = fc."film_id"
INNER JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Action'
GROUP BY c."category_id";

--Consulta 51
--Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE "clientes_rentas_temporales" AS
SELECT COUNT("rental_id"), c."customer_id",CONCAT(c."first_name", ' ', c."last_name")
FROM "rental" r
INNER JOIN "customer" c ON r."customer_id" = c."customer_id"
GROUP BY c."customer_id"
ORDER BY COUNT("rental_id") DESC; 

--Consulta 52
--Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE "peliculas_alquiladas" AS
SELECT f."film_id", f."title", COUNT(r."rental_id")
FROM "film" f
INNER JOIN "inventory" i ON f."film_id" = i."film_id"
INNER JOIN "rental" r ON i."inventory_id" = r."inventory_id"
GROUP BY f."title", f."film_id"
HAVING COUNT(r."rental_id") >= 10;

--Consulta 53
/*Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. 
 Ordena los resultados alfabéticamente por título de película.*/
SELECT r."rental_id", f."title" , CONCAT("first_name",' ',"last_name") AS cliente, c."customer_id"
FROM "customer" c
INNER JOIN "rental" r ON c."customer_id" = r."customer_id"
INNER JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
RIGHT JOIN "film" f ON i."film_id" = f."film_id"
WHERE CONCAT("first_name",' ',"last_name") = 'TAMMY SANDERS'
ORDER BY f."title" ASC;

--Consulta 54
/*Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. 
Ordena los resultados alfabéticamente por apellido.*/
SELECT DISTINCT a."first_name", a."last_name", c."name"
FROM "actor" a
INNER JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
RIGHT JOIN "film" f ON fa."film_id" = f."film_id"
INNER JOIN "film_category" fc ON f."film_id" = fc."film_id"
INNER JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Sci-Fi'
ORDER BY a."last_name" ASC;

--Consulta 55
/*Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ 
*se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.*/
SELECT DISTINCT a."first_name", a."last_name"
FROM "actor" a
INNER JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
INNER JOIN "film" f ON fa."film_id" = f."film_id"
INNER JOIN "inventory" i ON f."film_id" = i."film_id"
INNER JOIN "rental" r ON i."inventory_id" = r."inventory_id"
WHERE r."rental_date" > (
 SELECT MIN(r2."rental_date")
 FROM "film" f2
 INNER JOIN "inventory" i2 ON f2."film_id" = i2."film_id"
 INNER JOIN "rental" r2 ON i2."inventory_id" = r2."inventory_id"
 WHERE f2."title" = 'SPARTACUS CHEAPER')
ORDER BY a."last_name" ASC;

--Consulta 56
--Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
SELECT DISTINCT a."first_name", a."last_name", c."name"
FROM "actor" a
INNER JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
INNER JOIN "film" f ON fa."film_id" = f."film_id"
INNER JOIN "film_category" fc ON f."film_id" = fc."film_id"
INNER JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" <> 'Music';
--Podemos simplificar esta consulta introduciendo una subconsulta en el where solo que no aparecerán las categorias.
SELECT DISTINCT a."first_name", a."last_name"
FROM "actor" a
WHERE a."actor_id" NOT IN (
 SELECT DISTINCT fa."actor_id"
 FROM "film_actor" fa
 INNER JOIN "film" f ON fa."film_id" = f."film_id"
 INNER JOIN "film_category" fc ON f."film_id" = fc."film_id"
 INNER JOIN "category" c ON fc."category_id" = c."category_id"
 WHERE c."name" = 'Music')

--Consulta 57
-- Encuentra el título de todas las películas que fueron alquiladas por más de 8 días. 
SELECT f."title", (r."return_date"::DATE - r."rental_date"::DATE) AS " Días alquilada"
FROM "rental" r
INNER JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
RIGHT JOIN "film" f ON i."film_id" = f."film_id"
WHERE r."return_date" is not null
AND (r."return_date"::DATE - r."rental_date"::DATE) > 8;

--Consulta 58
--Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’. 
SELECT "title", "name"
FROM "film" f
INNER JOIN "film_category" fc ON f."film_id" = fc."film_id"
INNER JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Animation'

--Consulta 59
/*Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’.
 * Ordena los resultados alfabéticamente por título de película.*/
SELECT "title", "length"
FROM "film" f
WHERE "length" = (
 SELECT "length"
 FROM "film" f2
 WHERE "title" = 'DANCING FEVER');
 
--Consulta 60 
/*Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
Ordena los resultados alfabéticamente por apellido.*/
SELECT c."first_name", c."last_name", COUNT(DISTINCT i."film_id")
FROM "customer" c
INNER JOIN "rental" r ON c."customer_id" = r."customer_id"
INNER JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
GROUP BY c."first_name", c."last_name"
HAVING COUNT(DISTINCT i."film_id") >= 7
ORDER BY c."last_name" ASC;

--Consulta 61
/* Encuentra la cantidad total de películas alquiladas por categoría y muestra el 
nombre de la categoría junto con el recuento de alquileres.*/
SELECT COUNT(r."rental_id"), c."name", c."category_id"
FROM "category" c
INNER JOIN "film_category" fc ON c."category_id" = fc."category_id"
INNER JOIN "film" f ON fc."film_id" = f."film_id"
INNER JOIN "inventory" i ON f."film_id" = i."film_id"
INNER JOIN "rental" r ON i."inventory_id" = r."inventory_id"
GROUP BY c."category_id";

--Consulta 62
--Encuentra el número de películas por categoría estrenadas en 2006.
SELECT COUNT(r."rental_id"), c."name", c."category_id"
FROM "category" c
INNER JOIN "film_category" fc ON c."category_id" = fc."category_id"
INNER JOIN "film" f ON fc."film_id" = f."film_id"
INNER JOIN "inventory" i ON f."film_id" = i."film_id"
INNER JOIN "rental" r ON i."inventory_id" = r."inventory_id"
WHERE f."release_year" = 2006
GROUP BY c."category_id";

--Consulta 63
--Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT CONCAT(s."first_name", ' ', s."last_name"), "staff_id", s2."store_id"
FROM "staff" s
CROSS JOIN "store" s2; 

--Consulta 64
/*Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido 
junto con la cantidad de películas alquiladas.*/
SELECT c."customer_id", c."first_name", c."last_name", COUNT(r."rental_id") AS "Total Alquileres"
FROM "customer" c
INNER JOIN "rental" r ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id";

/*Vistas 
* film_data --> Incluye datos sobre las películas (titulo, duración, precio de alquiler, rating)
* actor_num_peliculas --> Incluye el nombre completo de los actores y el número de peliculas en las que ha participado