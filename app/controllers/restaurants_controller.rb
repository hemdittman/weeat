class RestaurantsController < ApplicationController
  before_action :query_restaurant, only: [:show, :update, :destroy]

  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  def show
    if @restaurant
      render json: @restaurant
    else
      render json: {error: "not-found"}, status: 404
    end
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
    @restaurant = Restaurant.where(id: params[:id]).first
  end

end
