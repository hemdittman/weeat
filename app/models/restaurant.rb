# == Schema Information
#
# Table name: restaurants
#
#  id                        :integer          not null, primary key
#  name                      :string           not null
#  cuisine_id                :integer          not null
#  rating                    :integer
#  accepts_10bis             :boolean          not null
#  address                   :string           not null
#  max_delivery_time_minutes :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Restaurant < ApplicationRecord

  validates_presence_of :name, :address, :max_delivery_time_minutes
  validates_inclusion_of :accepts_10bis, in: [true, false]

  belongs_to :cuisine
  has_many :reviews, dependent: :destroy


  def calc_rating
    self.rating = self&.reviews.average(:rating) ? reviews.average(:rating).round : nil
  end
end
