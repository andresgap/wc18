class LinkTournaments < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :tournament_id, :integer
    add_column :prediction_sets, :tournament_id, :integer
    add_column :phases, :tournament_id, :integer
    add_column :matches, :tournament_id, :integer
  end
end
