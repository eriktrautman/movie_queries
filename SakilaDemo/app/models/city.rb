class City < ActiveRecord::Base
  set_table_name(:city)
  set_primary_key(:city_id)

  has_many :addresses
  belongs_to :country

  # returns the count of movie rentals per city
  def self.movie_rentals
    self
      .select("COUNT(*) AS num_rentals")
      .joins(:addresses => { :store => { :inventories => :rentals } } )
      .group("city.city_id")
      .limit(5)
  end

end