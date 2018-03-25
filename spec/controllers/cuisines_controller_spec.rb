require 'rails_helper'

RSpec.describe CuisinesController, type: :controller do
  describe '#index' do
    it 'should return empty json when no cuisines exist' do
      get :index
      expect(response.body).to eq('[]')
    end

    it 'should render cuisines json' do
      create_list(:cuisine, 4)
      get :index
      expect(response).to be_success
      expect(response.body).to eq(Cuisine.all.to_json)
    end
  end

  describe '#show' do
    it 'should return 404 for non existent cuisine' do
      get :show, params: { id: 10 }
      expect(response).to be_not_found
    end

    it 'should return cuisinesdata' do
      cuisine = create(:cuisine)
      get :show, params: { id: cuisine.id }
      expect(response).to be_success
      expect(response.body).to eq(cuisine.to_json)
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'should create a cuisine' do
        post :create, params: { name: 'name'}
        expect(response).to be_success
        expect(response.body).to eq(Cuisine.first.to_json)
      end
    end

    context 'with invalid params' do
      it 'should return an error for empty name' do
        post :create, params: {}
        expect(response).to be_bad_request
      end

      it 'should return an error for existing cuisine' do
        cuisine = create(:cuisine)
        post :create, params: { name: cuisine.name }
        expect(response).to be_bad_request
      end
    end
  end

  describe '#update' do
    let!(:cuisine) { create(:cuisine) }

    context 'with valid params' do
      it 'should update cuisine with new name' do
        post :update, params: { id: cuisine.id, name: 'name' }
        expect(response).to be_success
        expect(cuisine.reload.name).to eq('name')
      end
    end

    context 'with invalid params' do
      it 'should fail for empty name' do
        post :update, params: { id: cuisine.id, name: '' }
        expect(response).to be_bad_request
      end

      it 'should fail for existing cuisine' do
        another_cuisine = create(:cuisine)
        post :update, params: { id: cuisine.id, name: another_cuisine.name }
        expect(response).to be_bad_request
      end
    end
  end

  describe '#destroy' do
    let!(:cuisine) { create(:cuisine) }
    let!(:cuisine_id) { cuisine.id }

    context 'with no restaurants' do
      it 'should destroy cuisine' do
        delete :destroy, params: { id: cuisine_id }
        expect(response).to be_ok
        expect(Cuisine.exists?(id: cuisine_id)).to be false
      end
    end

    context 'with restaurants' do
      let!(:restaurants) { create_list(:restaurant, 5, cuisine: cuisine) }

      it 'should fail to destroy cuisine' do
        delete :destroy, params: { id: cuisine_id }
        expect(response).to be_bad_request
        expect(Cuisine.exists?(id: cuisine_id)).to be true
      end
    end
  end
end
