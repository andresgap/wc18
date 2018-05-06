class Admin::MatchesController < ApplicationController
  include DefaultCrud

  before_action :authenticate_user!
  before_action :admin_access?
  before_action :set_active_page, only: [:index]
  before_action :load_teams, only: [:edit]

  private

  def set_active_page
    @active_page = 'admin'
  end

  def entity_parameters
    params
      .require(:match)
      .permit(:team1_id, :team2_id, :team1_score, :team2_score, :ready, :closed)
  end

  def load_entity_object_by_id
    @entity_object = entity.find(params[:match_id])
  end

  def load_all_entity_objects
    @all_entity_objects = entity.order(:number)
  end

  def load_teams
    @teams = Team.all.sort_by(&:name)
  end

end
