class LeaderboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :leaderboards_active_page, only: [:index]
  before_action :manage_active_page, only: [:manage]
  before_action :load_leaderboard,
    only: [:edit, :update, :leave, :leave_confirm, :members, :members_confirm]
  before_action :leaderboards, only: [:create, :update, :leave_confirm, :members_confirm]

  def index
    @general_board ||= PositionBoard.new
    @boards = current_user.leaderboards.map { |leaderboard| PositionBoard.new(leaderboard) }
  end

  def manage
    @leaderboards = current_user.leaderboards
    @invitations = current_user.invitations
  end

  def new
    @leaderboard = Leaderboard.new
  end

  def create
    leaderboard_params = parameters
    leaderboard_params.merge!(owner_id: current_user.id)
    @leaderboard = Leaderboard.create(leaderboard_params)
    if @leaderboard
      @leaderboard.code = SecureRandom.uuid
      @leaderboard.users << current_user
      @leaderboard.save
    end
  end

  def edit
    @leaderboard = Leaderboard.find(params[:id])
  end

  def update
    if @leaderboard.owner == current_user
      @leaderboard.update(parameters)
    else
      @leaderboard.errors.add(:owner, "Invalid")
    end
  end

  def leave_confirm
    @leaderboard.users.delete(current_user)
  end

  def members_confirm
    if @leaderboard.owner == current_user && params.key?(:users)
      user_ids = params.require(:users).permit(ids: [])['ids']
      user_ids.each { |id| @leaderboard.users.delete(User.find(id)) }
    end
  end

  private

  def leaderboards_active_page
    @active_page = 'leaderboards'
  end

  def manage_active_page
    @active_page = 'manage'
  end

  def parameters
    params.require(:leaderboard).permit(:name, :private)
  end

  def leaderboards
    @leaderboards = current_user.leaderboards
  end

  def load_leaderboard
    @leaderboard ||= Leaderboard.find(params[:id])
  end

end
