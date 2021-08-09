require 'rails_helper'

RSpec.describe 'New Item Page' do
  before :each do
    @merchant = create(:merchant, name: 'Eucalyptus')
    visit new_merchant_item_path(@merchant)
  end
  it 'can enter information and submit to be redirected to merchant item index and can see new item' do
    fill_in(:item_name, with: 'Lotion')
    fill_in(:item_description, with: 'aloe body lotion')
    fill_in(:item_unit_price, with: 6.50)
    click_button('Create Item')

    expect(current_path).to eq(merchant_items_path(@merchant))

    expect(page).to have_content('Lotion')
    expect(page).to have_button('Enable')
  end
  it 'returns error if fields are missing' do
    fill_in(:item_name, with: '')
    fill_in(:item_description, with: 'aloe body lotion')
    fill_in(:item_unit_price, with: 6.50)
    click_button('Create Item')

    expect(page).to have_content("Error: Name can't be blank")
    expect(page).to have_current_path(new_merchant_item_path(@merchant))
  end
end
