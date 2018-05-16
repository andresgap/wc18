class CreateLeaderboards < ActiveRecord::Migration[5.1]
  def change
    create_table :leaderboards do |t|
      t.string :name
      t.string :code
      t.integer :owner_id
      t.boolean :active, default: true
      t.boolean :private, default: true

      t.timestamps
    end
  end
end
