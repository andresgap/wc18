class Phase < ApplicationRecord
  has_many :matches
  belongs_to :tournament

  def name
    @name ||= I18n.t("phase.#{code}")
  end

end
