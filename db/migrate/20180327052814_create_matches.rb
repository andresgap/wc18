class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :number
      t.datetime :date
      t.integer :phase_id
      t.integer :team1_id
      t.integer :team2_id
      t.integer :team1_score
      t.integer :team2_score
      t.string :team1_label
      t.string :team2_label
      t.integer :tournament_id
      t.boolean :ready, default: true

      t.timestamps
    end
  end
end
