require 'rails_helper'

describe Resturant, type: :model do

  it 'is not valid witg a name of less than three characters' do
    resturant = Resturant.new(name: "kf")
    expect(resturant).to have(1).error_on(:name)
    expect(resturant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Resturant.create(name: "Moe's Tavern")
    resturant = Resturant.new(name: "Moe's Tavern")
    expect(resturant).to have(1).error_on(:name)
  end

  it 'has many reviews' do
    resturant = Resturant.create(name: "Moe's Tavern")
    expect(resturant).to have_many :reviews
  end

end

describe 'reviews' do
  describe 'build_with_user' do

    let(:user) { User.create email: 'test@test.com' }
    let(:resturant) { Resturant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }

    subject(:review) { resturant.reviews.build_with_user(review_params, user) }

    it 'builds a review' do
      expect(review).to be_a Review
    end

    it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
    end
  end
end

describe '#average_rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      resturant = Resturant.create(name: 'The Ivy')
      expect(resturant.average_rating).to eq 'N/A'
    end
  end

  context '1 review' do
    it 'returns that rating' do
      resturant = Resturant.create(name: 'The Ivy')
      resturant.reviews.create(rating: 4)
      expect(resturant.average_rating).to eq 4
    end
  end

  context 'multiple reviews' do
    it 'returns the average' do
      resturant = Resturant.create(name: 'The Ivy')
      resturant.reviews.create(rating: 1)
      resturant.reviews.create(rating: 5)
      expect(resturant.average_rating).to eq 3
    end
  end

end
