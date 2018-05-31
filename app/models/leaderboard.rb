class Leaderboard < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :invitations, dependent: :destroy

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  validates :name, presence: true, length: { in: 3..40 }, uniqueness: true
  validates :owner_id, presence: true

  scope :active, -> { where(active: true) }
  scope :closed, -> { where(private: true) }
  scope :opened, -> { where(private: false) }

  def users_predictions
    users.active.includes(:prediction_set).all
      .sort_by { |user| [user.prediction_set.points, user.name.downcase] }
  end

end
