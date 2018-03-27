class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :code
      t.string :group
      t.integer :tournament_id

      t.timestamps
    end
  end
end
