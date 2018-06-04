class Match < ApplicationRecord
  belongs_to :phase
  belongs_to :team1, class_name: 'Team', optional: true
  belongs_to :team2, class_name: 'Team', optional: true

  has_many :predictions

  def score_label
    closed? ? "#{team1_score} - #{team2_score}" : 'vs'
  end

  def last_hour?
    date - 1.hour < Time.current && !closed?
  end

  def closed?
    date - 5.minutes < Time.current
  end

  def valid_scores?
    team1_score.present? && team2_score.present?
  end

  def team1_win?
    team1_score > team2_score
  end

  def team2_win?
    team2_score > team1_score
  end

  def tie?
    team1_score == team2_score
  end

end
