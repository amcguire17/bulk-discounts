require 'rails_helper'

RSpec.describe 'Welcome Index Page' do
  before :each do
    visit '/'
  end
  it 'shows the name of the project' do
    expect(page).to have_content('Little Esty Shop')
  end
  it 'can link to admin dashboard and merchants index' do
    expect(page).to have_link('Admin Dashboard')
    expect(page).to have_link('Merchants Index')

    click_link 'Admin Dashboard'
    expect(current_path).to eq(admin_index_path)

    visit '/'
    click_link 'Merchants Index'
    expect(current_path).to eq(merchants_path)
  end
end
