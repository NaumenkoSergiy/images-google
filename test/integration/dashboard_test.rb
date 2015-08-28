require 'test_helper'
 
describe 'dashboard', :capybara do
  it 'browse site root path without login' do
    visit root_path
    page.must_have_content 'Sign in with Google'
  end

  it 'login to the site' do
    visit root_path
    click_link 'Sign in with Google'
    page.must_have_content 'Sign out'
  end
end
