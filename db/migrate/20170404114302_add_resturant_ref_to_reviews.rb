class AddResturantRefToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :resturant, index: true
  end
end
