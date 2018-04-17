class PredictionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]
  before_action :check_update_acess, only: [:update]

  def index
    @prediction_set =
      PredictionSet
        .where(user: current_user, tournament: tournament)
        .includes(predictions: { match: [:team1, :team2, :phase] })
        .first
  end

  def update
    prediction_set.update_attributes!(prediction_set_params)
    flash[:notice] = prediction_set.errors.any? ? I18n.t('form.error') : I18n.t('form.sucess')
    redirect_to predictions_path
  end

  private

  def set_active_page
    @active_page = 'predictions'
  end

  def check_update_acess
    redirect_to root_path unless current_user == prediction_set.user
  end

  def prediction_set
    @prediction_set ||= PredictionSet.where(id: params[:id]).first
  end

  def prediction_set_params
    params.require(:prediction_set).permit(:id, predictions_attributes: [:id, :score1, :score2])
  end

end
