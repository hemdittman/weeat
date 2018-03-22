class Restaurant < ApplicationRecord

  validates :name, :address, :accepts_10bis, :max_delivery_time_minutes, presence: true

  belongs_to :cuisine

end
