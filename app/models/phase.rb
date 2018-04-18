class Phase < ApplicationRecord
  belongs_to :tournament
  has_many :matches

  def name
    @name ||= I18n.t("phase.#{code}")
  end

end
