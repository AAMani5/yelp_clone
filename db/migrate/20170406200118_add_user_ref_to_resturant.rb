class AddUserRefToResturant < ActiveRecord::Migration
  def change
    add_reference :resturants, :user, index: true, foreign_key: true
  end
end
