class ReviewsController < ApplicationController
  # This controller is nested - its routes are under /restaurants/:restaurant_id/...

  before_action :query_review, only: [:show, :update, :destroy]

  def index
    @reviews = Review.where(restaurant_id: params[:restaurant_id]).all
    render json: @reviews
  end

  def show
    if @review
      render json: @review
    else
      render json: {error: "not-found"}, status: 404
    end
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

  # TODO consider adding users model and allow only the user that created the review to edit/delete it
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
    @review = Review.where(id: params[:id]).first
  end

end
