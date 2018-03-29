class CuisinesController < ApplicationController
  before_action :query_cuisine, only: %i[show update destroy]

  def index
    render json: Cuisine.all
  end

  def show
    render json: @cuisine
  end

  def create
    @cuisine = Cuisine.new
    update
  end

  def update
    if @cuisine.update(cuisine_params)
      render json: @cuisine
    else
      render json: @cuisine.errors.messages, status: :bad_request
    end
  rescue ActiveRecord::RecordNotUnique => e
    render json: { error: 'Cuisine with this name already exists' }, status: :bad_request
  end

  def destroy
    @cuisine.destroy!
    head :ok
  rescue ActiveRecord::DeleteRestrictionError
    render json: @cuisine.errors.messages, status: :bad_request
  end

  private

  def cuisine_params
    params.permit(:name)
  end

  def query_cuisine
    @cuisine = Cuisine.find(params.require(:id))
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: :not_found }, status: :not_found
  end

end
