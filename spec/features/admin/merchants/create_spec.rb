require 'rails_helper'

RSpec.describe 'admin merchant create page' do
  before :each do
    visit admin_merchants_path
  end
  it 'admin merchant index page has link to create new merchant' do
    click_link 'New Merchant'
    expect(current_path).to eq(new_admin_merchant_path)
  end

  it 'can create a new merchant and defaults to disabled' do
    fill_in 'Name', with: 'Chuck Norris'
    click_button('Create Merchant')

    expect(current_path).to eq(admin_merchants_path)

    within ("#disabled") do
      expect(page).to have_content('Chuck Norris')
    end
  end
end
