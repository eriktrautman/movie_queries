class City < ActiveRecord::Base
  set_table_name(:city)
  set_primary_key(:city_id)

  has_many :addresses
  belongs_to :country
end