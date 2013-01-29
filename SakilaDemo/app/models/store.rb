class Store < ActiveRecord::Base
  set_primary_key(:store_id)
  set_table_name(:store)

  # has_and_belongs_to_many :films, :join_table => "inventory"
  has_many :inventories
  has_many :films, :through => :inventories
  belongs_to :address
  has_one :country, :through => :address
  # has_many :actors, :through => :films

  # stores with most films
  def self.biggest_film_selection
    self
      .select("store.*, COUNT(DISTINCT(film.film_id)) AS num_films")
      .joins(:films)
      .group("store.store_id")
      .order("num_films DESC")
  end


  def self.biggest_inventory
    self
      .select("store.*, COUNT(*) AS num_films")
      .joins(:films)
      .group("store.store_id")
      .order("num_films DESC")
  end


end