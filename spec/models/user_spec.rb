require 'rails_helper'

describe User, type: :model do

  it 'has many reviews' do
    user = User.create(email:'test@test.com', password: 'testtest', password_confirmation: 'testtest')
    expect(user).to have_many :resturants
  end

  it 'has many reviews' do
    user = User.create(email:'test@test.com', password: 'testtest', password_confirmation: 'testtest')
    expect(user).to have_many :reviews
  end

  it 'has many reviewed resturants' do
    user = User.create(email:'test@test.com', password: 'testtest', password_confirmation: 'testtest')
    expect(user).to have_many :reviewed_resturants
  end

end
