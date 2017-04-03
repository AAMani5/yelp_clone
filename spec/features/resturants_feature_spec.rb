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

end
