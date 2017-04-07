class Resturant < ActiveRecord::Base
  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews,
 -> { extending WithUserAssociationExtension },
  dependent: :destroy
  belongs_to :user

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.count
  end


end
