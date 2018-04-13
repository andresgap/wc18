class PredictionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]

  def index
    @matches = Match.all
  end

  private

  def set_active_page
    @active_page = 'predictions'
  end

end
