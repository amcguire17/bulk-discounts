class GithubService < ApiService
  def self.repo_info
    get_link("https://api.github.com/repos/InOmn1aParatus/little-esty-shop")
  end

  def self.contributor_info
    get_link("https://api.github.com/repos/InOmn1aParatus/little-esty-shop/contributors")
  end

  def self.pulls_info
    get_link("https://api.github.com/repos/InOmn1aParatus/little-esty-shop/pulls?state=closed")
  end
end
