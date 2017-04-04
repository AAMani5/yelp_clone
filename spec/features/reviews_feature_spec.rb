require 'rails_helper'

feature 'reviewing' do
  before {Resturant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/resturants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/resturants'
    expect(page).to have_content('so so')
  end
end
