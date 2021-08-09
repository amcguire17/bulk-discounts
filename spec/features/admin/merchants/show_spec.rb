require 'rails_helper'

RSpec.describe 'admin merchants show page' do
  before :each do
    @merchant_1 = create(:merchant)
  end
  it 'links to merchant show page from index page' do
    visit admin_merchants_path
    click_link "#{@merchant_1.name}"
    expect(current_path).to eq(admin_merchant_path(@merchant_1))
  end
  it 'displays the merchant name' do
    visit admin_merchant_path(@merchant_1)
    expect(page).to have_content(@merchant_1.name)
  end
end
