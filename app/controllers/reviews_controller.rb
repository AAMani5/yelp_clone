class ReviewsController < ApplicationController

  def new
    @resturant = Resturant.find(params[:resturant_id])
    @review = Review.new
  end

  def create
    @resturant = Resturant.find(params[:resturant_id])
    @resturant.reviews.create(thoughts: params[:review][:thoughts], rating: params[:review][:rating], user_id: current_user.id, resturant_id: @resturant.id)
    redirect_to '/resturants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
