class PositionBoard

  attr_reader :leaderboard

  def initialize(leaderboard = nil)
    @leaderboard = leaderboard
  end

  def members
    @members ||= positions.sort_by { |position| [position.index, position.name.downcase] }
  end

  def title
    @title ||= leaderboard ? leaderboard.name : 'general'
  end

  private

  def positions
    @positions ||=
      prediction_sets.map { |prediction_set| OpenStruct.new(position_row(prediction_set)) }
  end

  def users
    @users ||= leaderboard ?
      leaderboard.users.active.includes(:prediction_set).all :
      User.active.includes(:prediction_set).all
        .reject { |user| user.prediction_set.points == 0 }
  end

  def prediction_sets
    @prediction_sets ||= PredictionSet.where(tournament: gc19).includes(:user).all
      #.reject { |prediction_set| prediction_set.points == 0 }
  end

  def position_row(prediction_set)
    {
      name: prediction_set.user.name,
      picture: prediction_set.user.picture,
      points: prediction_set.points,
      index: order_points.index(prediction_set.points) + 1,
      prediction_set: prediction_set
    }
  end

  def order_points
    @order_points ||= prediction_sets.map(&:points).sort.reverse.uniq
  end

  def gc19
    @gc19 ||= Tournament.where(code: 'GC19').first
  end

end
