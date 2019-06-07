class PredictionSet < ApplicationRecord
  belongs_to :user
  belongs_to :tournament

  has_many :predictions, dependent: :destroy

  accepts_nested_attributes_for :predictions

  class << self
    def build(user, tournament)
      set = PredictionSet.new(user: user, tournament: tournament)
      set.predictions = tournament.matches.all.map { |match| Prediction.new(match: match) }
      set.save!(validate: false)
    end
  end

  def closed_predictions
    predictions
      .includes(match: [:team1, :team2, :phase])
      .select { |prediction| prediction.match.closed? }
  end

end
