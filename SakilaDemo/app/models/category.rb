class Category < ActiveRecord::Base
  set_table_name(:category)
  set_primary_key(:category_id)

  has_and_belongs_to_many :films, :join_table => "film_category"

  has_many :actors, :through => :films

  has_many :customers, :through => :films

  has_many :rentals, :through => :films

  # most popular categories of film
  def self.most_popular
    self
      .select("category.*, COUNT(*) AS films_in_category")
      .joins(:films)
      .group("category.category_id")
      .order("films_in_category DESC")
      .limit(10)
  end

  def self.most_rented
    self
      .select("category.*, COUNT(*) AS number_rented")
      .joins(:rentals)
      .group("category.category_id")
      .order("number_rented DESC")
      .limit(10)
  end

end