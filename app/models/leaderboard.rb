class Leaderboard < ApplicationRecord
  has_and_belongs_to_many :users

  def users_predictions
    users.active.includes(:prediction_set).all
      .sort_by { |user| [user.prediction_set.points, user.name] }
  end
end
