class ReviewsController < ApplicationController
  # This controller is nested - its routes are under /restaurants/:restaurant_id/...

  before_action :query_review, only: %i[show update destroy]

  def index
    render json: Review.where(restaurant_id: params.require(:restaurant_id))
  end

  def show
    render json: @review
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: @review
    else
      render json: @review.errors.messages
    end
  end

  def update
    if @review.update(rating: review_params[:rating], comment: review_params[:comment])
      render json: @review
    else
      render json: @review.errors.messages
    end
  end

  def destroy
    if @review.destroy
      head :ok
    else
      render json: @review.errors.messages
    end
  end

  private

  def review_params
    params.permit(:rating, :comment, :reviewer_name, :restaurant_id)
  end

  def query_review
    @review = Review.find_by!(id: params.require(:id), restaurant_id: params.require(:restaurant_id))
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: :not_found }, status: 404
  end

end
