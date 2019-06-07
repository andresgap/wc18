class Team < ApplicationRecord
  belongs_to :tournament

  has_many :matches, ->(team) do
    unscope(:where).where("team1_id = :team_id OR team2_id = :team_id", team_id: team.id)
  end

  def name
    @name ||= I18n.t("team.#{tournament.code}.#{code}")
  end

  def flag
    @flag ||= "flags/#{tournament.code}/#{code}.png"
  end

end
