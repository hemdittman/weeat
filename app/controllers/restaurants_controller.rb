class RestaurantsController < ApplicationController
  before_action :query_restaurant, only: %i[show update destroy]

  def index
    render json: Restaurant.all
  end

  def show
    render json: @restaurant
  end

  def create
    @restaurant = Restaurant.new(rest_params)
    if @restaurant.save
      render json: @restaurant
    else
      render json: @restaurant.errors.messages
    end
  end

  def update
    if @restaurant.update(rest_params)
      render json: @restaurant
    else
      render json: @restaurant.errors.messages
    end
  end

  def destroy
    if @restaurant.destroy
      head :ok
    else
      render json: @restaurant.errors.messages
    end
  end

  private

  def rest_params
    params.permit(:name, :cuisine_id, :accepts_10bis, :address, :max_delivery_time_minutes)
  end

  def query_restaurant
    @restaurant = Restaurant.find(params.require(:id))
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: :not_found }, status: 404
  end

end
