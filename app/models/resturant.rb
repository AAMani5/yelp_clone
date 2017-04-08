class Resturant < ActiveRecord::Base
  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews,
            -> { extending WithUserAssociationExtension },
            dependent: :destroy
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/assets/missing.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.count
  end


end
