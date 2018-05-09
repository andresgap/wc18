class Prediction < ApplicationRecord
  belongs_to :prediction_set
  belongs_to :match

  validate :match_open?

  def match_open?
    errors.add(:time_error, ", this match is already closed") if match.closed?
  end

end
