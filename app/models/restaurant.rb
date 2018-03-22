class Restaurant < ApplicationRecord

  validates_presence_of :name, :address, :max_delivery_time_minutes
  validates_inclusion_of :accepts_10bis, in: [true, false]

  belongs_to :cuisine
  has_many :reviews


  def calc_rating
    reviews_ratings = reviews.map(&:rating)
    self.rating = reviews_ratings.empty? ? nil : reviews_ratings.inject(:+) / reviews_ratings.size
    save
  end
end
