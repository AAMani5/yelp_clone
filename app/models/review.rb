class Review < ActiveRecord::Base
  belongs_to :resturant
  belongs_to :user
  validates :rating, inclusion: (1..5)
  has_many :endorsements
  # validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
end
