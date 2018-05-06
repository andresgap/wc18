class HelpController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]

  def index
  end

  private

  def set_active_page
    @active_page = 'help'
  end

end
