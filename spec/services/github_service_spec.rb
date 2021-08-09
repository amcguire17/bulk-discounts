require 'rails_helper'

RSpec.describe GithubService do
  it 'returns the repos data' do
    mock_response = "{\"id\":389774449,\"name\":\"little-esty-shop\"}"

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    repo = GithubService.repo_info

    expect(repo).to be_a(Hash)
    expect(repo).to have_key(:id)
    expect(repo).to have_key(:name)
  end
  it 'returns the contributor data' do
    mock_response = "[{\"login\":\"InOmn1aParatus\",\"id\":56685055,\"contributions\":80},{\"login\":\"chsweet\",\"id\":81600649,\"contributions\":1000}]"

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    repo = GithubService.contributor_info

    expect(repo).to be_a(Array)
    expect(repo[0]).to have_key(:login)
    expect(repo[0]).to have_key(:id)
    expect(repo[0]).to have_key(:contributions)

    expect(repo[1]).to have_key(:login)
    expect(repo[1]).to have_key(:id)
    expect(repo[1]).to have_key(:contributions)
  end
  it 'returns the pulls data' do
    mock_response = "[
    {\"id\":702945116,\"number\":55,\"state\":\"closed\",\"title\":\"Api consumption\",\"user\":{\"login\":\"InOmn1aParatus\",\"id\":56685055}},
    {\"id\":702478711,\"number\":54,\"state\":\"closed\",\"title\":\"Status update\",\"user\":{\"login\":\"ealwafai\",\"id\":77654906}}
    ]"

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    repo = GithubService.pulls_info

    expect(repo).to be_a(Array)
    expect(repo[0]).to have_key(:id)
    expect(repo[0]).to have_key(:number)
    expect(repo[0]).to have_key(:title)
    expect(repo[0]).to have_key(:user)
    expect(repo[0][:user]).to have_key(:login)

    expect(repo[1]).to have_key(:id)
    expect(repo[1]).to have_key(:number)
    expect(repo[1]).to have_key(:title)
    expect(repo[1]).to have_key(:user)
    expect(repo[1][:user]).to have_key(:login)
  end
end
