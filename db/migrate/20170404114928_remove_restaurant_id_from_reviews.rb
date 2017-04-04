class RemoveRestaurantIdFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :restaurant_id, :integer
  end
end
