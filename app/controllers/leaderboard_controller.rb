class LeaderboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]

  def index
    @prediction_sets =
      PredictionSet.where(tournament: tournament).includes(:user).all
        .sort_by { |set| [set.points, set.user.name] }
  end

  private

  def set_active_page
    @active_page = 'leaderboard'
  end

end
