class CuisinesController < ApplicationController
  before_action :query_cuisine, only: %i[show update destroy]

  def index
    render json: Cuisine.all
  end

  def show
    render json: @cuisine
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
    @cuisine = Cuisine.find(params.require(:id))
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: :not_found }, status: 404
  end

end
