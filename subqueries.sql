USE sakila;
#1.List all films whose length is longer than the average of all the films.
USE sakila;
set @variable := (
select avg(length) from film);

SELECT title, length
FROM film
WHERE length > @variable;

#2.How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT count(title) FROM inventory
JOIN film
USING(film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY title

#3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name 
FROM actor
JOIN film_actor
USING(actor_id)
JOIN film
USING (film_id)
WHERE title = 'Alone Trip';

#4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT name, title  FROM film
JOIN film_category
USING(film_id)
JOIN category
USING(category_id)
WHERE name = 'Family'

#5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

# ---using joins
SELECT first_name, last_name, email, country from customer
JOIN address
USING(address_id)
JOIN city
USING(city_id)
JOIN country
USING(country_id)
WHERE country = 'Canada'

# --- using subqueries
SELECT first_name, last_name, email from (select country, country_id)  as 1
					from 
					(select country_id, city_id )
                    from 
                    (select city_id, address_id )
                    from
                    (select address_id from )
                    (address_id from customer) as customer_info);
                    

# 6. 
select title from film
where film_id IN
(select film_id from film_actor
where actor_id =  
(select actor_id from film_actor
group by actor_id
order by count(*) desc
limit 1));


#7 

select title from film
where film_id IN
(select film_id from inventory
where inventory_id IN 
(select inventory_id from rental
where rental_id IN 
(select rental_id from rental
WHERE customer_id =
(select customer_id from payment
group by customer_id
order by sum(amount) desc
limit 1))))