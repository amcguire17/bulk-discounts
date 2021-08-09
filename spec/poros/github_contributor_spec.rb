require 'rails_helper'

RSpec.describe GithubContributor do
  before :each do
    @contributor_info = [
      {id: 56685055,:login=>"InOmn1aParatus", :contributions=>75},
      {id: 79383963,:login=>"amcguire17", :contributions=>42},
      {id: 77654906,:login=>"ealwafai", :contributions=>41},
      {id: 81600649,:login=>"chsweet", :contributions=>35},
      {id: 8150461,:login=>"BrianZanti", :contributions=>33}
    ]
  end
  it 'returns a contributors attribute' do
    repo = GithubContributor.new(@contributor_info)
    expected = {
      "InOmn1aParatus" => 75,
      "amcguire17" => 42,
      "ealwafai" => 41,
      "chsweet" => 35
    }
    expect(repo.contributors).to eq(expected)
  end
end
