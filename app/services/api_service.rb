class ApiService
  def self.get_link(link)
    response = Faraday.get(link)
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end
