require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Resturant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    visit '/resturants'
    click_link 'Endorse Review' #are we endorsing restaurants or the review of the restaurants?
    # click_button 'Confirm Endorsement'
    expect(page).to have_content 'It was an abomination'
    expect(page).to have_content('1 endorsement')
  end

end
