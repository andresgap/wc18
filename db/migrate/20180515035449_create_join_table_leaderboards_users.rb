class CreateJoinTableLeaderboardsUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :leaderboards, :users do |t|
      t.index [:leaderboard_id, :user_id]
      t.index [:user_id, :leaderboard_id]
    end
  end
end
