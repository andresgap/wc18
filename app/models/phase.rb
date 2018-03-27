class Phase < ApplicationRecord
  belongs_to :tournament
  has_many :matches
end
