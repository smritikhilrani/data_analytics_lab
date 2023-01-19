#1. Which actor has appeared in the most films?
Use sakila;
SELECT 
	count(actor_id) as count,
    actor_id,
    first_name
FROM film_actor
JOIN actor
USING (actor_id)
GROUP BY actor_id
ORDER BY count desc
LIMIT 1;


# 2. Most active customer (the customer that has rented the most number of films)
SELECT 
    first_name,
    count(customer_id) as count1
FROM customer
JOIN rental
USING(customer_id)
GROUP BY customer_id
ORDER BY count1 desc
LIMIT 1;

# 3. List number of films per category.
SELECT count(*), category_id, name
FROM film_category
JOIN category
USING(category_id)
GROUP BY category_id;

 # 4.Display the first and last names, as well as the address, of each staff member.
 SELECT first_name, 
		last_name,
        address
FROM address
JOIN staff
USING(address_id);

#5. get films titles where the film language is either English or italian, and whose titles starts with letter "M" , sorted by title descending.
SELECT title,
		`name`
FROM film
JOIN `language`
USING(language_id)
WHERE name IN ('English', 'Italian') 
AND title like 'M%';

#6. Display the total amount rung up by each staff member in August of 2005.

select first_name, last_name, sum(amount) from staff
join payment
using(staff_id)
where payment_date like '2005-08%'
GROUP BY staff_id

select payment_date from payment



# 7. List each film and the number of actors who are listed for that film.
SELECT count(actor_id),
		title
FROM film
JOIN film_actor
USING(film_id)
GROUP BY title

# 8. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name.
SELECT SUM(amount) as total_paid,
		first_name
FROM customer
JOIN payment 
USING(customer_id)
GROUP BY customer_id;

# 9. Write sql statement to check if you can find any actor who never particiapted in any film.
SELECT actor_id
FROM film_actor
JOIN actor
USING(actor_id)
WHERE actor_id IS NULL
	
# 10. get the addresses that has NO customers, and ends with the letter "e"
SELECT address,
		first_name
FROM customer
RIGHT JOIN address
USING(address_id)
WHERE first_name IS NULL
AND address LIKE '%e';

# 11. what is the most rented film?
select title, count(*) as count from inventory
JOIN rental
USING(inventory_id)
JOIN film
USING(film_id)
GROUP BY title
ORDER BY count desc
LIMIT 1;