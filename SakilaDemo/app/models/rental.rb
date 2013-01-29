class Rental < ActiveRecord::Base
  set_table_name(:rental)
  set_primary_key(:rental_id)

  belongs_to :inventory
  belongs_to :customer

  has_one :film, :through => :inventory

  has_many :categories, :through => :film

end