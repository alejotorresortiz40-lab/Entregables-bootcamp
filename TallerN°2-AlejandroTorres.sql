##TALLER 2

##Parte 1 – SELECT y WHERE
#1. Mostrar nombre y apellido de todos los clientes, utilizamos el select con la variable que queríamos ver, poniendo el FROM para identificar de que tabla lo queriamos visualizar.
#2. Películas con duración mayor a 120 minutos, igual que en el paso anterior, solo añadimos el WHERE para poner una condición de tiempo con lenght.

SELECT first_name, last_name FROM customer; 
SELECT * FROM film
WHERE length >= 120;

##Parte 2 – ORDER BY
#3. Ordenar clientes por apellido --> Por orden alfabetico de la A a la Z. Se utiliza un ORDER BY con el comando ASC, ya que nos mostrará los apellidos con las letras iniciales del abecedario, hasta las finales. 
#4. Top 5 películas más largas --> TIP: Use la palabra LIMIT. Hacemos lo contrario, ya que las  películas están ordenadas desde la menor duración hasta la mayor, se utiliza el comando DESC

SELECT first_name, last_name FROM customer
ORDER BY last_name ASC;
SELECT * FROM film
ORDER BY length DESC
LIMIT 5;

##Parte 3 – INNER JOIN
#5. Cantidad pagada y fecha del pago con nombre y apellido del cliente (JOIN entre Payment - Customer). Unimos payment y customer por su llave en común customer_id
#6. Películas alquiladas JOIN entre Rental - Inventory - Film. Usamos inventory como tabla puente entre rental y film

SELECT first_name, last_name, amount, payment_date
FROM payment 
JOIN customer ON payment.customer_id = customer.customer_id;
SELECT film.title
FROM rental 
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film  ON inventory.film_id = film.film_id;

##Parte 4 – LEFT JOIN
#Nombre y apellido de clientes sin pagos (LEFT JOIN entre Payment - Customer pero usando WHERE). LEFT JOIN incluye todos los clientes, IS NULL filtra los que no tienen pagos
#Listar los nombres de las peliculas y su duracion de aquellos titulos que no tienen actores. film_actor es la tabla puente entre film y actor, IS NULL filtra las películas que no tienen actores asociados

SELECT customer.first_name, customer.last_name
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.payment_id IS NULL;

SELECT film.title, film.length
FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IS NULL;

##Parte 5 – INSERT, UPDATE, DELETE (Data Definition Language )
#Insertar actor temporal
#Actualizar actor
#Eliminar actor

INSERT INTO actor (first_name, last_name)
VALUES ('Dwayne','Jhonson');

UPDATE actor
SET first_name = 'The rock', last_name = 'Jhonson'
WHERE actor_id = 201; #WHERE es obligatorio para no actualizar todos los registros

DELETE FROM actor
WHERE actor_id = 201; #WHERE es obligatorio para no eliminar todos los registros

##Parte 6 - Consultas Avanzadas
#Top 5 clientes con mayor cantidad de dinero pagado al servicio de rentas. SUM agrupa el total pagado por cliente, ORDER BY lo ordena de mayor a menor
#Top 5 Películas más alquiladas (JOIN entre Rental - Inventory - Film) --> Agrupar los datos con conteo y tomar las mejores 5. COUNT cuenta cuántas veces aparece cada película en rental. Usamos inventory como tabla puente entre rental y film

SELECT c.first_name, c.last_name, SUM(p.amount) AS total_pagado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_pagado DESC
LIMIT 5;

SELECT f.title, COUNT(r.rental_id) AS total_alquilado
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY total_alquilado DESC
LIMIT 5;
