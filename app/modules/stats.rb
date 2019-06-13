class Stats

  def list
    matches.map { |match| build(match) }.to_h
  end

  private

  def matches
    @matches ||= gc19.matches.includes(:predictions).all
  end

  def build(match)
    valid_predictions = match.predictions.select(&:valid_scores?)
    stats = valid_predictions.any? ? stats_values(valid_predictions) : empty_stats
    [match.number, OpenStruct.new(stats)]
  end

  def stats_values(predictions)
    {
      team1: (predictions.select(&:team1_win?).size / predictions.size.to_f * 100).to_f,
      team2: (predictions.select(&:team2_win?).size / predictions.size.to_f * 100).to_f,
      tie: (predictions.select(&:tie?).size / predictions.size.to_f * 100).to_f
    }
  end

  def empty_stats
    { team1: 0, team2: 0, tie: 0 }
  end

end
