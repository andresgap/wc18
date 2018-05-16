class LeaderboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]
  before_action :general_predictions, only: [:index]
  before_action :leaderboards, only: [:index]

  private

  def set_active_page
    @active_page = 'leaderboards'
  end

  def general_predictions
    @general_predictions ||=
      User.active.includes(:prediction_set).all
        .sort_by { |user| [user.prediction_set.points, user.name] }
  end

  def leaderboards
    @leaderboards = current_user.leaderboards.select(&:active)
  end


end
