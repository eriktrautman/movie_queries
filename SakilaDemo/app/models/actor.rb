class Actor < ActiveRecord::Base

  set_table_name(:actor)
  set_primary_key(:actor_id)

  has_many :film_actors
  has_many :films, :through => :film_actors
  # has_and_belongs_to_many :films, :join_table => "film_actor"

  #has_many :films
  has_many :categories, :through => :films

  # select the actors that have been in the most films
  def self.most_prolific
    self
      .select("actor.first_name, actor.last_name, COUNT(actor.actor_id) AS num_films")
      .joins(:films)
      .group("actor.actor_id")
      .order("COUNT(actor.actor_id) DESC")
      .limit(10)
  end
end