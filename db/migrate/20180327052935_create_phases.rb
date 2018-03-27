class CreatePhases < ActiveRecord::Migration[5.1]
  def change
    create_table :phases do |t|
      t.string :code
      t.integer :level
      t.integer :small_points
      t.integer :big_points

      t.timestamps
    end
  end
end
