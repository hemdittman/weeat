require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#validations' do
    it { is_expected.to validate_presence_of :rating }
    it { is_expected.to validate_presence_of :reviewer_name }
    it { is_expected.to validate_numericality_of(:rating)
                        .is_less_than_or_equal_to(3)
                        .with_message('Rating value should be between 1 to 3') }
    it { is_expected.to validate_numericality_of(:rating)
                        .is_greater_than_or_equal_to(1)
                        .with_message('Rating value should be between 1 to 3') }
  end

  describe '#update_restaurant_rating' do
    it 'should update restaurant rating upon creation' do
      rest = create(:restaurant)
      expect(rest.rating).not_to be

      review = create(:review, restaurant: rest)
      expect(rest.rating).to eq(review.rating)
    end

    it 'should update restaurant rating upon update' do
      rest = create(:restaurant)
      review = create(:review, restaurant: rest, rating: 2)
      expect(rest.rating).to eq(2)
      review.update!(rating: 1)
      expect(rest.rating).to eq(1)
    end

    it 'should update restaurant rating upon destroy' do
      rest = create(:restaurant)
      review = create(:review, restaurant: rest, rating: 2)
      expect(rest.rating).to eq(2)
      review.destroy!
      expect(rest.rating).not_to be
    end
  end
end
