require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  describe '#index' do
    it 'should return empty json when no restaurants exist' do
      get :index
      expect(response.body).to eq('[]')
    end

    it 'should render restaurants json' do
      create_list(:restaurant, 4)
      get :index
      expect(response).to be_success
      expect(response.body).to eq(Restaurant.all.to_json)
    end
  end

  describe '#show' do
    it 'should return 404 for non existent restaurant' do
      get :show, params: { id: 10 }
      expect(response).to be_not_found
    end

    it 'should return restaurants data' do
      rest = create(:restaurant)
      get :show, params: { id: rest.id }
      expect(response).to be_success
      expect(response.body).to eq(rest.to_json)
    end
  end

  describe '#create' do
    let!(:cuisine) { create(:cuisine) }
    let!(:params)  {{ name: 'name', address: 'address', max_delivery_time_minutes: 90, accepts_10bis: true,
                      cuisine_id: cuisine.id }}

    context 'with valid params' do
      it 'should create a restaurant' do
        post :create, params: params
        expect(response).to be_success
        expect(response.body).to eq(Restaurant.first.to_json)
      end
    end

    context 'with invalid params' do
      it 'should return an error for empty cuisine' do
        post :create, params: params.except(:cuisine_id)
        expect(response).to be_bad_request
      end

      it 'should retrun en error for invalid cuisine_id' do
        params[:cuisine_id] = cuisine.id + 1
        post :create, params: params
        expect(response).to be_bad_request
      end

      it 'should return an error for empty name' do
        post :create, params: params.except(:name)
        expect(response).to be_bad_request
      end

      it 'should return an error for empty address' do
        post :create, params: params.except(:address)
        expect(response).to be_bad_request
      end

      it 'should return an error for empty delivery time' do
        post :create, params: params.except(:max_delivery_time_minutes)
        expect(response).to be_bad_request
      end

      it 'should return an error for empty accepts_10bis' do
        post :create, params: params.except(:accepts_10bis)
        expect(response).to be_bad_request
      end

      it 'should return an error for existing [name, address] combo' do
        Restaurant.create!(params)
        post :create, params: params
        expect(response).to be_bad_request
      end
    end
  end

  describe '#update' do
    let!(:restaurant) { create(:restaurant) }
    let!(:params) { restaurant.as_json }

    context 'with valid params' do
      it 'should update a restaurant with new values' do
        cuisine = create(:cuisine)
        updated_params = { id: restaurant.id, name: 'new_name', address: 'new address',
                           max_delivery_time_minutes: restaurant.max_delivery_time_minutes + 10,
                           accepts_10bis: !restaurant.accepts_10bis, cuisine_id: cuisine.id }
        post :update, params: updated_params
        expect(response).to be_success
        expect(restaurant.reload.as_json.symbolize_keys.except(:created_at, :updated_at, :rating)).to eq(updated_params)
      end
    end

    context 'with invalid params' do
      it 'should return an error for invalid id' do
        params[:id] = restaurant.id + 1
        post :update, params: params
        expect(response).to be_not_found
      end

      it 'should return an error for empty cuisine' do
        params[:cuisine_id] = ''
        post :update, params: params
        expect(response).to be_bad_request
      end

      it 'should retrun en error for invalid cuisine_id' do
        params[:cuisine_id] = cuisine.id + 1
        post :update, params: params
        expect(response).to be_bad_request
      end

      it 'should return an error for empty name' do
        params[:name] = ''
        post :update, params: params
        expect(response).to be_bad_request
      end

      it 'should return an error for empty address' do
        params[:address] = ''
        post :update, params: params
        expect(response).to be_bad_request
      end

      it 'should return an error for empty delivery time' do
        params[:max_delivery_time_minutes] = ''
        post :update, params: params
        expect(response).to be_bad_request
      end

      it 'should return an error for empty accepts_10bis' do
        params[:accepts_10bis] = ''
        post :update, params: params
        expect(response).to be_bad_request
      end

      it 'shouldnt update restaurants rating' do
        params[:rating] = 3
        post :update, params: params
        expect(response).to be_success
        expect(restaurant.reload.rating).not_to be
      end

      it 'should return an error for existing [name, address] combo' do
        existing_rest = create(:restaurant)
        params[:name] = existing_rest.name
        params[:address] = existing_rest.address
        post :update, params: params
        expect(response).to be_bad_request
      end

    end
  end

  describe '#destroy' do
    let!(:restaurant) { create(:restaurant) }
    let!(:reviews) { create_list(:review, 5, restaurant: restaurant) }
    let!(:rest_id) { restaurant.id }

    before :each do
      delete :destroy, params: { id: rest_id }
    end

    it { is_expected.to respond_with :ok}

    it 'should destroy restaurant' do
      expect(Restaurant.exists?(id: rest_id)).to be false
    end

    it 'should destroy dependent reviews' do
      expect(Review.all).to be_empty
    end
  end

end
