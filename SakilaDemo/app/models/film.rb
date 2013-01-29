class Film < ActiveRecord::Base
  set_table_name(:film)
  set_primary_key(:film_id)

  has_many :film_actors
  has_many :actors, :through => :film_actors

  has_and_belongs_to_many :categories, :join_table => "film_category"

  has_many :inventories
  has_many :stores, :through => :inventories

  has_many :rentals, :through => :inventories
  has_many :customers, :through => :rentals

  # has_and_belongs_to_many :stores, :join_table => "inventory"
  # films with the largest casts
  def self.largest_casts
    self
      .select("film.*, COUNT(*) AS cast_size")
      .joins(:actors)
      .group("film.film_id")
      .order("cast_size DESC")
      .limit(5)
  end

  def self.most_stores
    self
      .select("film.*, COUNT(*) AS num_of_stores")
      .joins(:stores)
      .group("film.film_id")
      .order("num_of_stores DESC")
      .limit(5)
  end

  def self.most_watched
    self
      .select("film.*, COUNT(*) AS viewers")
      .joins(:rentals)
      .group("film.film_id")
      .order("viewers DESC")
      .limit(5)
  end


end