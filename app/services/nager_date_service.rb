class NagerDateService < ApiService
  def self.holiday_info
    get_link("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end

  def self.next_three_holidays
    holidays = holiday_info.map do |data|
      NagerData.new(data)
    end
    holidays[0..2]
  end
end
