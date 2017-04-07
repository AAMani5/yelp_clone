require 'rails_helper'

feature 'reviewing' do
  before do
    Resturant.create name: 'KFC'
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'allows users to leave only one review using a form' do
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/resturants'
    expect(page).to have_content('so so')
    expect(page).not_to have_link 'Review KFC'
  end

end
