-- 1. List all customers who live in Texas (use JOINs)
-- answer: Jennifer Davis, Kim Cruz, Richard Mccrary, Bryran Hardison, Ian Still
SELECT customer.first_name,customer.last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id  
WHERE address.district = 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM payment
INNER JOIN customer
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99
ORDER BY amount ASC;


-- 3. Show all customers names who have made payments over $175(use subqueries)--
SELECT *
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);
-- 4. List all customers that live in Nepal (use the city table)
-- answer = Kevin Schuler

SELECT first_name, last_name, country
FROM customer 
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';


-- 5. Which staff member had the most transactions?
-- answer: Jon Stephens
SELECT first_name, last_name, COUNT(payment_id)
FROM staff	 
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name,last_name;


-- 6. How many movies of each rating are there?--
--Answer: R = 195, NC-17 = 210, PG-13 = 223, G = 178, PG = 194
SELECT rating, COUNT(rating)
FROM film
FULL JOIN film_category
ON film.film_id = film_category.film_id
GROUP BY rating;



-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)--
SELECT *
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id, amount
	HAVING amount > 6.99
);



-- 8. How many free rentals did our stores give away?--
-- Answer: 24
SELECT amount, COUNT(amount)
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY amount;
