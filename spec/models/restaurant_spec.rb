require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '#calc_rating' do
    it 'should update restaurant rating with reviews avg' do
      rest = create(:restaurant)
      create_list(:review, 4, restaurant: rest)
      rest.calc_rating
      expect(rest.rating).to eq(rest.reviews.average(:rating).round)
    end

    it 'should set nil for rating when no reviews exist' do
      rest = create(:restaurant)
      rest.calc_rating
      expect(rest.rating).not_to be
    end
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :max_delivery_time_minutes }
    it { is_expected.to validate_inclusion_of(:accepts_10bis).in_array([true, false]) }
  end
end
