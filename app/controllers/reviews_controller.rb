class ReviewsController < ApplicationController

  def new
    @resturant = Resturant.find(params[:resturant_id])
    @review = Review.new
  end

  def create
    @resturant = Resturant.find(params[:resturant_id])
    @review = @resturant.reviews.create(review_params)
    current_user.reviews << @review
    redirect_to '/resturants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
