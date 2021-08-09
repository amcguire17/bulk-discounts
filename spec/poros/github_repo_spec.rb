require 'rails_helper'

RSpec.describe GithubRepo do
  before :each do
    @repo_info = {:id=>389774449, :name=>"little-esty-shop"}
  end
  it 'returns a name attribute' do
    repo = GithubRepo.new(@repo_info)
    expect(repo.name).to eq("little-esty-shop")
  end
end
