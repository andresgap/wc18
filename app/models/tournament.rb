class Tournament < ApplicationRecord
  has_many :matches
  has_many :teams
  has_many :phases
  has_many :prediction_sets

  def name
    @name ||= I18n.t("tournament.#{code}")
  end

end
