class Prediction < ApplicationRecord
  belongs_to :prediction_set
  belongs_to :match

end
