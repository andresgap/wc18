class Prediction < ApplicationRecord
  belongs_to :prediction_set
  belongs_to :match

  validate :match_open?

  default_scope -> { order(:match_id) }

  def match_open?
    errors.add(:match_error, "this match is already closed!") if match.closed?
  end

  def valid_scores?
    score1.present? && score2.present?
  end

  def team1_win?
    score1 > score2
  end

  def team2_win?
    score2 > score1
  end

  def tie?
    score1 == score2
  end

end
