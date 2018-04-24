class Admin::MatchesController < ApplicationController
  include DefaultCrud

  before_action :authenticate_user!
  before_action :admin_access?

  private

  def entity_parameters
    params
      .require(:match)
      .permit(:team1_id, :team2_id, :team1_score, :team2_score, :show, :ended)
  end

  def load_entity_object_by_id
    @entity_object = entity.find(params[:match_id])
  end

  def load_all_entity_objects
    @all_entity_objects = entity.order(:number)
  end


end
