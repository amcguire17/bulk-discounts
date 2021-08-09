require 'rails_helper'

RSpec.describe 'Edit Item Page' do
  before :each do
    @merchant = create(:merchant, name: 'Eucalyptus')
    @item = create(:item, merchant: @merchant, unit_price: 3456)
    visit edit_merchant_item_path(@merchant, @item)
  end
  it 'has previous information on form to edit' do
    expect(page).to have_field(:item_name, with: "#{@item.name}")
    expect(page).to have_field(:item_description, with: "#{@item.description}")
    expect(page).to have_field(:item_unit_price, with: "$#{@item.unit_price_dollars}")
  end
  it 'can enter new information and submit to be redirected to merchant item page and see update notice' do
    fill_in(:item_name, with: 'Lotion')
    fill_in(:item_description, with: 'aloe body lotion')
    fill_in(:item_unit_price, with: 650)
    click_button('Update Item')

    expect(current_path).to eq(merchant_item_path(@merchant, @item))
    expect(page).to have_content('Lotion')
    expect(page).to have_content('Description: aloe body lotion')
    expect(page).to have_content('Current Price: $6.50')

    expect(page).to have_content("Item information has been successfully updated")
  end
end
