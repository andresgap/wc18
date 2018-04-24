class Prediction < ApplicationRecord
  belongs_to :prediction_set
  belongs_to :match

  def points_label
    "#{points} pts" if points
  end

  def points
  end

end
