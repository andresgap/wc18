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
    gc19 = Tournament.where(code: 'GC19').first
    ca19 = Tournament.where(code: 'CA19').first
    if !PredictionSet.exists?(user: user, tournament: gc19)
      PredictionSet.build(user, gc19)
    end
    if !PredictionSet.exists?(user: user, tournament: ca19)
      PredictionSet.build(user, ca19)
    end
    super(user)
  end

  def gc19
    @gc19 ||= Tournament.where(code: 'GC19').first
  end

  def ca19
    @ca19 ||= Tournament.where(code: 'CA19').first
  end

end
