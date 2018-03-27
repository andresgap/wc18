class Tournament < ApplicationRecord
  has_many :phases
  has_many :teams
  has_many :matches
end
