require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:restaurant) { create(:restaurant) }

  describe '#index' do
    let!(:reviews) { create_list(:review, 5, restaurant: restaurant)}
    let!(:another_rest) { create(:restaurant) }
    let!(:another_review) { create(:review, restaurant: another_rest) }

    before :each do
      get :index, params: { restaurant_id: restaurant.id }
    end

    it { is_expected.to respond_with :ok }
    it 'should return reviews data' do
      expect(response.body).to eq(Review.where(restaurant: restaurant).to_json)
    end

    it 'shouldnt return another restaurant reviews' do
      expect(response.body).not_to include(another_review.to_json)
    end
  end

  describe '#show' do
    let!(:review) { create(:review, restaurant: restaurant) }
    let!(:another_rest) { create(:restaurant) }
    let!(:another_review) { create(:review, restaurant: another_rest) }

    context 'with invalid params' do
      it 'should return 404 for invalid restaurant' do
        get :show, params: { restaurant_id: restaurant.id, id: another_review.id}
        expect(response).to be_not_found
      end

      it 'should return 404 for invalid review' do
        get :show, params: { restaurant_id: another_rest.id, id: review.id}
        expect(response).to be_not_found
      end

      it 'should return 404 for non existent restaurant' do
        get :show, params: { restaurant_id: another_rest.id + 1, id: review.id }
        expect(response).to be_not_found
      end

      it 'should return 404 for non existent review' do
        get :show, params: { restaurant_id: restaurant.id, id: another_review.id + 1 }
        expect(response).to be_not_found
      end
    end

    context 'with valid params' do
      it 'should return reviews data' do
        get :show, params: { id: review.id, restaurant_id: restaurant.id }
        expect(response).to be_success
        expect(response.body).to eq(review.to_json)
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'should create a review with comment' do
        post :create, params: { restaurant_id: restaurant.id, rating: 1, reviewer_name: 'reviewer', comment: 'comment'}
        expect(response).to be_success
        expect(response.body).to eq(Review.first.to_json)
      end

      it 'should create a review without a comment' do
        post :create, params: { restaurant_id: restaurant.id, rating: 1, reviewer_name: 'reviewer'}
        expect(response).to be_success
        expect(response.body).to eq(Review.first.to_json)
      end
    end

    context 'with invalid params' do
      it 'should fail with rating lower than 1' do
        post :create, params: { restaurant_id: restaurant.id, rating: 0, reviewer_name: 'reviewer'}
        expect(response).to be_bad_request
        expect(restaurant.reviews).to be_blank
      end

      it 'should fail with rating greater than 3' do
        post :create, params: { restaurant_id: restaurant.id, rating: 4, reviewer_name: 'reviewer'}
        expect(response).to be_bad_request
        expect(restaurant.reviews).to be_blank
      end

      it 'should fail for no rating' do
        post :create, params: { restaurant_id: restaurant.id, reviewer_name: 'reviewer'}
        expect(response).to be_bad_request
        expect(restaurant.reviews).to be_blank
      end

      it 'should fail for no reviewer' do
        post :create, params: { restaurant_id: restaurant.id, rating: 2}
        expect(response).to be_bad_request
        expect(restaurant.reviews).to be_blank
      end
    end
  end

  describe '#update' do
    context ''
  end
end
