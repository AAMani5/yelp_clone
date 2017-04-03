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

  def show
    @resturant = Resturant.find(params[:id])
  end

  def edit
    @resturant = Resturant.find(params[:id])
  end

  def update
    @resturant = Resturant.find(params[:id])
    @resturant.update(resturant_params)

    redirect_to '/resturants'
  end

  def destroy
   @resturant = Resturant.find(params[:id])
   @resturant.destroy
   flash[:notice] = 'Resturant deleted successfully'
   redirect_to '/resturants'
  end

  private

  def resturant_params
    params.require(:resturant).permit(:name, :description)
  end

end
