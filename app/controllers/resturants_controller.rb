class ResturantsController < ApplicationController

  def index
    @resturants = Resturant.all
  end

end
