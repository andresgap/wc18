class Phase < ApplicationRecord
  has_many :matches

  def name
    @name ||= I18n.t("phase.#{code}")
  end

end
