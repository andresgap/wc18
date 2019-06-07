class AddActiveFlagToTournament < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :active, :boolean, default: true
  end
end
