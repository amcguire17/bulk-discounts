require 'rails_helper'

RSpec.describe GithubPulls do
  before :each do
    @pulls_info = [
      {user:{:login=>"InOmn1aParatus"}},
      {user:{:login=>"InOmn1aParatus"}},
      {user:{:login=>"InOmn1aParatus"}},
      {user:{:login=>"ealwafai"}},
      {user:{:login=>"ealwafai"}},
      {user:{:login=>"chsweet"}},
      {user:{:login=>"chsweet"}},
      {user:{:login=>"chsweet"}},
      {user:{:login=>"chsweet"}},
      {user:{:login=>"amcguire17"}},
      {user:{:login=>"amcguire17"}}
    ]
  end
  it 'returns a pull requests attribute' do
    repo = GithubPulls.new(@pulls_info)
    expected = {
      "InOmn1aParatus" => 3,
      "amcguire17" => 2,
      "ealwafai" => 2,
      "chsweet" => 4
    }
    expect(repo.pull_requests).to eq(expected)
  end
end
