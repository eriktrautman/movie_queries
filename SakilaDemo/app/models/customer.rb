class Customer < ActiveRecord::Base
  set_table_name(:customer)
  set_primary_key(:customer_id)

  has_many :rentals

  has_many :films, :through => :rentals

  has_many :categories, :through => :films


  # who have watched the most films
  def self.most_different_films_seen
    self
      .select("customer.*, COUNT(DISTINCT(film.film_id)) AS movies_watched")
      .joins(:films)
      .group("customer.customer_id")
      .order("movies_watched DESC")
      .limit(5)
  end

  def films_per_category
    self.categories
      .select("category.name, COUNT(*) AS movies_per_category")
      .group("category.category_id")
      .order("movies_per_category DESC")
  end


end