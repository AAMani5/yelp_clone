require 'rails_helper'

feature 'resturants' do

  context 'can' do
    before do
      Resturant.create name: 'KFC', description: 'Deep fried goodness'
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link('Sign out')
    end

    scenario ' not be created if a user is not logged in' do
      visit '/resturants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_link 'Add a resturant'
    end

    scenario ' be created by logged in users' do
      visit('/users/sign_in')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      click_button('Log in')
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_link 'Add a resturant'
    end
  end

  context 'no resturants have been added' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link('Sign out')
    end

    scenario 'should display a prompt to add a resturant' do
      visit('/users/sign_in')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      click_button('Log in')
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

  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'user can upload images when creating a new one' do
    click_link 'Add a resturant'
    expect(current_path).to eq '/resturants/new'
    fill_in 'Name' , with: 'KFC'
    fill_in 'Description', with: 'Tasty goodness'
    attach_file('rest_image', File.absolute_path('/Users/ashwinimani/Downloads/missing.jpg'))
    click_button 'Create Resturant'
    expect(page).to have_content 'KFC'
    expect(page).to have_xpath("//img[contains(@src,'missing.jpg')]")
    expect(current_path).to eq '/resturants'
  end

  scenario 'prompts user to fill out a form, then displays the new resturant' do
    click_link 'Add a resturant'
    expect(current_path).to eq '/resturants/new'
    fill_in 'resturant[name]' , with: 'KFC'
    click_button 'Create Resturant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/resturants'
  end

  scenario 'does not let you submit a name that is too short' do
    visit '/resturants'
    click_link 'Add a resturant'
    fill_in 'Name', with: 'kf'
    click_button 'Create Resturant'
    expect(page).not_to have_css 'h2', text: 'kf'
    expect(page).to have_content 'error'
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

  before  do
    Resturant.create name: 'Burger King', description: 'Deep fried goodness', id: 1
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'let a user edit a restaurant created by him/her' do
    visit '/resturants'
    click_link 'Add a resturant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Resturant'
    expect(page).to have_content 'KFC'
    click_link 'Edit KFC'
    fill_in 'Name', with: 'Kentucky Fried Chicken'
    fill_in 'Description', with: 'Deep fried goodness'
    click_button 'Update Resturant'
    click_link 'Kentucky Fried Chicken'
    expect(page).to have_content 'Kentucky Fried Chicken'
    expect(page).to have_content 'Deep fried goodness'
  end

  scenario 'dose not allow user to edit random resturant' do
    visit('/resturants')
    expect(page).not_to have_link 'Edit Burger King'
  end

end

context 'deleting resturants' do

  before  do
    Resturant.create name: 'Burger King', description: 'Deep fried goodness', id: 1
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'removes a resturant(created by the user) when user clicks a delete link' do
    visit '/resturants'
    click_link 'Add a resturant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Resturant'
    expect(page).to have_content 'KFC'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Resturant deleted successfully'
  end

  scenario 'dose not allow user to delete random resturant' do
    visit('/resturants')
    expect(page).not_to have_link 'Delete Burger King'
  end

end

end
