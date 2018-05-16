class Invitation < ApplicationRecord
  belongs_to :leaderboard
  belongs_to :user
end
