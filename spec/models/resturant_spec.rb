require 'rails_helper'

describe Resturant, type: :model do

  it 'is not valid witg a name of less than three characters' do
    resturant = Resturant.new(name: "kf")
    expect(resturant).to have(1).error_on(:name)
    expect(resturant).not_to be_valid
  end

end
