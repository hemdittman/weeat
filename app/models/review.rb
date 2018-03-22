class Review < ApplicationRecord

  validates :rating, :reviewer_name, presence: true
  validates_numericality_of :rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 3,
                            message: 'Rating value should be between 1 to 3'

  after_create :update_restaurant_rating
  after_update :update_restaurant_rating, if: proc { |review| review.rating_changed? }
  after_destroy :update_restaurant_rating

  belongs_to :restaurant, dependent: :destroy

  private

  def update_restaurant_rating
    restaurant.calc_rating
  end
end
