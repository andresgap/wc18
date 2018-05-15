class LeaderboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]
  before_action :users_predictions, only: [:index]

  def index
    @leaderboards = current_user.leaderboards
  end

  private

  def set_active_page
    @active_page = 'leaderboards'
  end

  def users_predictions
    @users_predictions ||=
      User.active.includes(:prediction_set).all
        .sort_by { |user| [user.prediction_set.points, user.name] }
  end

end
