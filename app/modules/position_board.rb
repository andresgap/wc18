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
    @positions ||= users.map { |user| OpenStruct.new(position_row(user)) }
  end

  def users
    @users ||= leaderboard ?
      leaderboard.users.active.includes(:prediction_set).all :
      User.active.includes(:prediction_set).all
  end

  def position_row(user)
    {
      name: user.name,
      picture: user.picture,
      points: user.prediction_set.points,
      index: order_points.index(user.prediction_set.points) + 1,
      prediction_set: user.prediction_set
    }
  end

  def order_points
    @order_points ||= users.map { |user| user.prediction_set.points }.sort.reverse.uniq
  end

end
