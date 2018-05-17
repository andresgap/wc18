class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_leaderboard, only: [:new, :create, :accept]
  before_action :load_invitation, only: [:accept, :reject]

  def new
    @invitation = Invitation.new(leaderboard: @leaderboard)
    @users = User.active.all.sort_by(&:name).reject { |user| @leaderboard.users.include?(user) }
  end

  def create
    invitation_params = parameters
    invitation_params.merge!(leaderboard_id: @leaderboard.id)
    @invitation = Invitation.where(parameters).first
    if @invitation
      @invitation.errors.add(:user, "Invitation already sent")
    elsif @leaderboard.owner != current_user
      @invitation = Invitation.new
      @invitation.errors.add(:leaderboard, "Invalid")
    else
      @invitation = Invitation.create(invitation_params)
    end
  end

  def accept
    @leaderboard.users << @invitation.user
    @invitation.delete
    @invitations = current_user.invitations
    @leaderboards = current_user.leaderboards
  end

  def reject
    @invitation.delete
    @invitations = current_user.invitations
  end

  private

  def parameters
    params.require(:invitation).permit(:user_id)
  end

  def load_invitation
    @invitation ||= Invitation.find(params[:id])
  end

  def load_leaderboard
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
  end

end
