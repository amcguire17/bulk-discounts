class ApplicationController < ActionController::Base
  # layout "application"
  # before_action :set_layout_variables
  #
  # def set_layout_variables
  #   @repo = GithubRepo.new(GithubService.repo_info)
  #   @repo_contributors = GithubContributor.new(GithubService.contributor_info)
  #   @repo_pulls = GithubPulls.new(GithubService.pulls_info)
  # end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
