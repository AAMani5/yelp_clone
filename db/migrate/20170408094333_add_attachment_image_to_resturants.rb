class AddAttachmentImageToResturants < ActiveRecord::Migration
  def self.up
    change_table :resturants do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :resturants, :image
  end
end
