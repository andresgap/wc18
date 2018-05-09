class Match < ApplicationRecord
  belongs_to :phase
  belongs_to :tournament
  belongs_to :team1, class_name: 'Team', optional: true
  belongs_to :team2, class_name: 'Team', optional: true

  has_many :predictions

  def score_label
    closed ? "#{team1_score} - #{team2_score}" : 'vs'
  end

  def last_hour?
    date - 1.hour < Time.current && !closed?
  end

  def closed?
    date - 5.minutes < Time.current
  end

end
