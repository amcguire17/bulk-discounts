require 'rails_helper'

RSpec.describe NagerData do
  before :each do
    @holiday_info = {:date=>"2021-09-06", :name=>"Labour Day"}
  end
  it 'returns a name attribute' do
    holiday = NagerData.new(@holiday_info)
    expect(holiday.date).to eq("2021-09-06")
    expect(holiday.name).to eq("Labour Day")
  end
end
