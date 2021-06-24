--1. A customer wants to know the films about “astronauts”. 
--How many recommendations could you give for him?

SELECT COUNT(*) FROM film
WHERE description LIKE '%Astronaut%';

--2. I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?

SELECT COUNT(*) AS "count list"
FROM film
WHERE rating = 'R'
AND
replacement_cost > 5
AND
replacement_cost < 15;

--3. We have two staff members with staff IDs 1 and 2. 
--   We want to give a bonus to the staff member that handled the most payments. 
--   How many payments did each staff member handle? 
--   And how much was the total amount processed by each staff member?

SELECT payment.staff_id, COUNT(*) AS "total payment handling"
FROM payment
GROUP BY payment.staff_id;

SELECT payment.staff_id, SUM(payment.amount) AS "total amount"
FROM payment
GROUP BY payment.staff_id;

--4. Corporate headquarters is auditing the store! 
--   They want to know the average replacement cost of movies by rating!

SELECT rating, AVG(replacement_cost) AS "average replacement cost"
FROM film
GROUP BY rating;

--5. We want to send coupons to the 5 customers who have spent the most amount of money. 
--   Get the customer name, email and their spent amount!

SELECT  CONCAT(customer.first_name,' ', customer.last_name) as "name", customer.email, SUM(payment.amount) as "spent amount" FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

--6. We want to audit our stock of films in all of our stores. 
--   How many copies of each movie in each store, do we have?

select COUNT(inventory.store_id) as "count copies", inventory.store_id, film.title
FROM inventory
JOIN film
ON inventory.film_id = film.film_id
GROUP BY inventory.store_id, film.title
ORDER BY film.title;

--7. We want to know what customers are eligible for our platinum credit card. 
--   The requirements are that the customer has at least a total of 40 transaction payments. 
--   Get the customer name, email who are eligible for the credit card! 

select CONCAT(customer.first_name, ' ', customer.last_name) as "name", customer.email
from payment
join customer
on payment.customer_id = customer.customer_id
group by customer.first_name, customer.last_name, customer.email
having COUNT(*) >= 40;

