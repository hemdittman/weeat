class CuisinesController < ApplicationController
  before_action :query_cuisine, only: [:show, :update, :destroy]

  def index
    @cuisines = Cuisine.all
    render json: @cuisines
  end

  def show
    if @cuisine
      render json: @cuisine
    else
      render json: {error: "not-found"}, status: 404
    end
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      render json: @cuisine
    else
      render json: @cuisine.errors.messages
    end
  end

  def update
    if @cuisine.update(cuisine_params)
      render json: @cuisine
    else
      render json: @cuisine.errors.messages
    end
  end

  def destroy
    if @cuisine.destroy
      head :ok
    else
      render json: @cuisine.errors.messages
    end
  end

  private

  def cuisine_params
    params.permit(:name)
  end

  def query_cuisine
    @cuisine = Cuisine.where(id: params[:id]).first
  end

end
