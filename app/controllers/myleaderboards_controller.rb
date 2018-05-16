class MyleaderboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_page, only: [:index]
  before_action :load_leaderboard, only: [:edit, :update]
  before_action :load_leaderboard_with_id, only: [:leave, :leave_confirm, :invite, :invite_confirm]
  before_action :leaderboards, only: [:index, :create, :update, :leave_confirm, :invite_confirm]
  before_action :load_users, only: [:invite, :invite_confirm]

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

  def invite_confirm
    # @leaderboard.users.add(user)
  end

  private

  def set_active_page
    @active_page = 'leaderboards'
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

  def load_leaderboard_with_id
    @leaderboard ||= Leaderboard.find(params[:myleaderboard_id])
  end

  def load_users
    @users = User.active.all.sort_by(&:name)
  end

end
