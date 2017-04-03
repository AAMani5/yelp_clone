require 'rails_helper'

feature 'resturants' do

  context 'no resturants have been added' do
    scenario 'should display a prompt to add a resturant' do
      visit '/resturants'
      expect(page).to have_content 'No resturants yet'
      expect(page).to have_link 'Add a resturant'
    end
  end

  context 'resturants have been added'do
  before do
    Resturant.create(name: 'KFC')
  end

  scenario 'display resturants' do
    visit '/resturants'
    expect(page).to have_content('KFC')
    expect(page).not_to have_content('No resturants yet')
  end

end

context 'creating resturants' do

  scenario 'prompts user to fill out a form, then displays the new resturant' do
    visit '/resturants'
    click_link 'Add a resturant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Resturant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/resturants'
  end
end

context 'viewing resturants' do

  let!(:kfc) {Resturant.create(name: 'KFC')}

  scenario 'lets a user view a resturant' do
    visit '/resturants'
    click_link 'KFC'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq "/resturants/#{kfc.id}"
  end
end

context 'editing resturants' do

  before { Resturant.create name: 'KFC', description: 'Deep fried goodness', id: 1 }
  scenario 'let a user edit a restaurant' do
    visit '/resturants'
    click_link 'Edit KFC'
    fill_in 'Name', with: 'Kentucky Fried Chicken'
    fill_in 'Description', with: 'Deep fried goodness'
    click_button 'Update Resturant'
    click_link 'Kentucky Fried Chicken'
    expect(page).to have_content 'Kentucky Fried Chicken'
    expect(page).to have_content 'Deep fried goodness'
    expect(current_path).to eq '/resturants/1'
  end

end

context 'deleting resturants' do

  before { Resturant.create name: 'KFC', description: 'Deep fried goodness' }

  scenario 'removes a resturant when a user clicks a delete link' do
    visit '/resturants'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Resturant deleted successfully'
  end

end


end
