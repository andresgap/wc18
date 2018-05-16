class Admin::LeaderboardsController < ApplicationController
  include DefaultCrud

  before_action :authenticate_user!
  before_action :admin_access?
  before_action :set_active_page, only: [:index]

  private

  def set_active_page
    @active_page = 'admin'
  end

  def entity_parameters
    params.require(:leaderboard).permit(:active, :private)
  end

  def load_entity_object_by_id
    @entity_object = entity.find(params[:leaderboard_id])
  end

  def load_all_entity_objects
    @all_entity_objects = entity.order(:name)
  end

end
