class CreateResturants < ActiveRecord::Migration
  def change
    create_table :resturants do |t|
      t.string :name
      t.integer :rating

      t.timestamps
    end
  end
end
