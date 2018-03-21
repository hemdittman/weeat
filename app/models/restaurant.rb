class Restaurant < ApplicationRecord

  belongs_to :cuisine

  validates :name, :address, :accepts_10bis, :max_delivery_time_minutes, presence: true

end
