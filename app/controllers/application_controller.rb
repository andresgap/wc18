class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to unauthenticated_root_path, notice: I18n.t('error.unauthorized')
    end
  end

  def admin_access?
    redirect_to root_path, alert: I18n.t('error.unauthorized') unless current_user.admin?
  end

  def after_sign_in_path_for(user)
    if user.sign_in_count < 2 && !PredictionSet.exists?(user: user, tournament: tournament)
      PredictionSet.build(user, tournament)
    end
    super(user)
  end

  def tournament
    @tournament ||= Tournament.first
  end

end
