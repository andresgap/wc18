class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.integer :phase_id
      t.datetime :date
      t.integer :team1_score
      t.integer :team2_score
      t.integer :tournament_id

      t.timestamps
    end
  end
end
