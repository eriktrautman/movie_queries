class Country < ActiveRecord::Base
  set_table_name(:country)
  set_primary_key(:country_id)

  has_many :cities
  has_many :addresses, :through => :cities
  has_many :stores, :through => :addresses

  def self.most_popular_actor
    self
      .select("country.country, actor.*, COUNT(actor.actor_id) AS actor_count")
      .joins(:stores => { :inventories => { :film => :actors } })
      .group("country.country_id, actor.actor_id")
      .order("actor_count DESC")
      .limit(5)

  end

end

#get all rentals for a country
#get all actors for those rentals
#count & group

# Country.first
#   .select("country.*, COUNT(actor.actor_id) as num_rentals")
#   .joins(:actor)
#   .group("actor.actor_id")
#   .order("num_rentals")
