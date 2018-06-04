class Points

  attr_reader :match

  def initialize(match)
    @match = match
  end

  def process
    return unless match.valid_scores?
    match.predictions.each { |prediction| update_prediction(prediction) }
    PredictionSet.includes(:predictions).all.each { |prediction_set| update_set(prediction_set) }
  end

  private

  def update_prediction(prediction)
    prediction.points = calculate_points(prediction)
    prediction.save(validate: false)
  end

  def calculate_points(prediction)
    return 0 unless prediction.valid_scores?
    if match.team1_score == prediction.score1 && match.team2_score == prediction.score2
      phase.big_points
    elsif match.team1_win? && prediction.team1_win? ||
      match.team2_win? && prediction.team2_win? ||
      match.tie? && prediction.tie?
      phase.small_points
    else
      0
    end
  end

  def phase
    @phase ||= match.phase
  end

  def update_set(prediction_set)
    prediction_set.points = prediction_set.predictions.map(&:points).compact.reduce(:+)
    prediction_set.save
  end

end
