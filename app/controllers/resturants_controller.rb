class ResturantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @resturants = Resturant.all
  end

  def new
    @resturant = Resturant.new
  end

  def create
    @resturant = Resturant.new(name: params[:resturant][:name], description: params[:resturant][:description], user_id:current_user.id)
    if @resturant.save
      redirect_to resturants_path
    else
      render 'new'
    end

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
