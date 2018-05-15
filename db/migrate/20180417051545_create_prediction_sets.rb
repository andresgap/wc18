class CreatePredictionSets < ActiveRecord::Migration[5.1]
  def change
    create_table :prediction_sets do |t|
      t.integer :user_id
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
