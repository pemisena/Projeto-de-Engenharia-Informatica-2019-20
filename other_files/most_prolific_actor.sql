# List the names of the actor with a 
# number of film appearences within 10 
# that of the number of film apperances of the most 
# prolific actor
SELECT afc.actor, afc.N_films AS "Number of films"
FROM (
	SELECT DISTINCT CONCAT(A.first_name, ' ' , A.last_name) AS "Actor",
	COUNT(FA.film_id) AS N_Films
	FROM actor A, film_actor FA
	WHERE A.actor_id = FA.actor_id
	GROUP BY A.actor_id, A.first_name, A.last_name
	ORDER BY COUNT(FA.film_id) DESC
) AS afc
WHERE afc.N_Films + 9 >= (
		SELECT MAX(fcounts)
        FROM(
			SELECT count(*) as fcounts
            FROM actor a, film_actor fa
            WHERE a.actor_id=fa.actor_id
            GROUP BY a.actor_id
		) AS temp
)