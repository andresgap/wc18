class RulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]

  def index
    @phases = Phase.all.select { |phase| phase.level > 1 }
  end

  private

  def set_active_page
    @active_page = 'rules'
  end

end