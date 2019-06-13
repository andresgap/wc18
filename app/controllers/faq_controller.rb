class FaqController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]

  def index
    @phases = gc19.phases.all.select { |phase| phase.level > 1 }
  end

  private

  def set_active_page
    @active_page = 'faq'
  end

end
