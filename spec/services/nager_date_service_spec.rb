require 'rails_helper'

RSpec.describe NagerDateService do
  before :each do
    @mock_response = "[{\"date\":\"2021-09-06\",\"name\":\"Labour Day\"},
                      {\"date\":\"2021-10-11\",\"name\":\"Columbus Day\"},
                      {\"date\":\"2021-11-11\",\"name\":\"Veterans Day\"},
                      {\"date\":\"2021-11-25\",\"name\":\"Thanksgiving Day\"},
                      {\"date\":\"2021-12-24\",\"name\":\"Christmas Day\"}]"

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(@mock_response)
  end
  it 'returns the holiday data' do
    holiday = NagerDateService.holiday_info

    expect(holiday).to be_a(Array)
    expect(holiday.first).to have_key(:date)
    expect(holiday.first).to have_key(:name)
    expect(holiday.second).to have_key(:date)
    expect(holiday.second).to have_key(:name)
    expect(holiday.third).to have_key(:date)
    expect(holiday.third).to have_key(:name)
    expect(holiday.fourth).to have_key(:date)
    expect(holiday.fourth).to have_key(:name)
    expect(holiday.fifth).to have_key(:date)
    expect(holiday.fifth).to have_key(:name)
  end
  it 'creates a list of next 3 holiday objects' do
    three_holiday = NagerDateService.next_three_holidays

    expect(three_holiday.count).to eq(3)
    expect(three_holiday.first).to be_a(NagerData)
    expect(three_holiday.first.name).to eq("Labour Day")
  end
end
