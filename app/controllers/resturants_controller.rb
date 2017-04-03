class ResturantsController < ApplicationController

  def index
    @resturants = Resturant.all
  end

  def new
    @resturant = Resturant.new
  end

  def create
    Resturant.create(resturant_params)
    redirect_to '/resturants'
  end

  private

  def resturant_params
    params.require(:resturant).permit(:name)
  end

end
