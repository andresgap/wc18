class LeaderboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]

  def index
    @prediction_sets = users_with_predictions
  end

  private

  def set_active_page
    @active_page = 'leaderboards'
  end

  def users_with_predictions
    PredictionSet
      .where(tournament: tournament).includes(:user)
      .all
      .select { |set| set.user.active }
      .sort_by { |set| [set.points, set.user.name] }
  end

end
