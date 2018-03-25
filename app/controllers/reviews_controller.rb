class ReviewsController < ApplicationController
  # This controller is nested - its routes are under /restaurants/:restaurant_id/...

  before_action :query_review, only: [:show, :update, :destroy]

  def index
    render json: Review.where(restaurant_id: params.require(:restaurant_id)).all
  end

  def show
    render json: @review
  end

  def create
    @review = Review.new(review_params)
    @review.restaurant = params[:restaurant_id]

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
    params.permit(:rating, :comment, :reviewer_name)
  end

  def query_review
    @review = Review.where(params.require(params[:id]))
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: :not_found }, status: 404
  end

end
