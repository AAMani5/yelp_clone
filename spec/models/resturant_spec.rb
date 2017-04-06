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
