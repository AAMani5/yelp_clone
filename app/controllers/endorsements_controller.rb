class EndorsementsController < ApplicationController

  def new
    # @review = Review.find(params[:review_id])
    # @endorsement = Endorsement.new
    create
  end

  def create
     @review = Review.find(params[:review_id])
     @review.endorsements.create
     redirect_to resturants_path
   end

end
