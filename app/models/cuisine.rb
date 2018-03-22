class Cuisine < ApplicationRecord

  validates_presence_of :name

  has_many :restaurants

end
