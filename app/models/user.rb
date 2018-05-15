class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :prediction_set
  has_and_belongs_to_many :leaderboards

  scope :active, -> { where(active: true) }

  def password_required?
    new_record? ? false : super
  end

  def admin?
    admin
  end

  def profile_image
    image || 'default.png'
  end

  def profile_icon
    picture || 'default.png'
  end

end
