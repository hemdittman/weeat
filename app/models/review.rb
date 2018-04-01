# == Schema Information
#
# Table name: reviews
#
#  id            :integer          not null, primary key
#  reviewer_name :string
#  rating        :integer
#  comment       :text
#  restaurant_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Review < ApplicationRecord

  validates_presence_of :rating, :reviewer_name
  validates_numericality_of :rating, greater_than_or_equal_to: 1, less_than_or_equal_to: 3,
                            message: 'Rating value should be between 1 to 3'

  after_save :update_restaurant_rating, if: proc { |review| review.saved_change_to_rating? }
  after_destroy :update_restaurant_rating

  belongs_to :restaurant

  private

  def update_restaurant_rating
    restaurant.update_rating
  end
end
