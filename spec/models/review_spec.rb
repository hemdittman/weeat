require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#validations' do
    it { is_expected.to validate_presence_of :rating }
    it { is_expected.to validate_presence_of :reviewer_name }
    it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(3)}
    it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(1)}
  end

  describe '#update_restaurant_rating' do
    it 'should update restaurant rating upon creation' do
      
    end

    it 'should update restaurant rating upon update' do

    end

    it 'should update restaurant rating upon destroy' do

    end
  end
end
