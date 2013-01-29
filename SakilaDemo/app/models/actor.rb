class Actor < ActiveRecord::Base
  set_table_name(:actor)
  set_primary_key(:actor_id)

  has_many :film_actors
  has_many :films, :through => :film_actors
  has_many :categories, :through => :films
  #has_many :stores, :through => :films

  # select the actors that have been in the most films
  def self.most_prolific
    self
      .select("actor.first_name, actor.last_name, COUNT(*) AS num_films")
      .joins(:films)
      .group("actor.actor_id")
      .order("num_films DESC")
      .limit(10)
  end

  def self.longest_career
    self
      .select("actor.*, ( MAX(film.release_year) - MIN(film.release_year)) AS career_length")
      .joins(:films)
      .group("actor.actor_id")
      .order("career_length DESC")
      .limit(10)
  end

  # returns actors with the top average grosses per film
  def self.best_avg_gross
    self.find_by_sql(
      "
        SELECT actor.*, AVG(gross_proceeds.gross) as avg_gross
        FROM actor
          JOIN film_actor ON actor.actor_id = film_actor.actor_id
          JOIN film AS film1 ON film_actor.film_id = film1.film_id
          JOIN
            (
              SELECT film2.film_id as film_id, (COUNT(rental.rental_id) * film2.rental_rate) AS gross
              FROM film AS film2
                JOIN inventory ON film2.film_id = inventory.film_id
                JOIN rental ON inventory.inventory_id = rental.inventory_id
              GROUP BY film2.film_id
            )
          AS gross_proceeds ON film1.film_id = gross_proceeds.film_id
        GROUP BY actor.actor_id
        ORDER BY avg_gross DESC
        LIMIT 10
      "
    )
  end


end