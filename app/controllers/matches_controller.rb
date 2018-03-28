class MatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @matches = Match.all
  end

end
