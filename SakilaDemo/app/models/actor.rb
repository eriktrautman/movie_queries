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

  def self.


end