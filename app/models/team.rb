class Team < ApplicationRecord

  has_many :matches, ->(team) do
    unscope(:where).where("team1_id = :team_id OR team2_id = :team_id", team_id: team.id)
  end

  def name
    @name ||= I18n.t("team.#{code}")
  end

  def flag
    @flag ||= "flags/#{code}.png"
  end

end
