class ReviewsController < ApplicationController

  def new
    @resturant = Resturant.find(params[:resturant_id])
    @review = Review.new
  end
end
