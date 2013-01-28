class Category < ActiveRecord::Base
  set_table_name(:category)
  set_primary_key(:category_id)

  # has_many :film_categories
  # has_many :films, :through => :film_categories

  has_and_belongs_to_many :films, :join_table => "film_category"
  has_many :actors, :through => :films

end