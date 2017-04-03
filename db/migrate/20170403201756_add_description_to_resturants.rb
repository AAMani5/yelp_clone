class AddDescriptionToResturants < ActiveRecord::Migration
  def change
    add_column :resturants, :description, :text
  end
end
