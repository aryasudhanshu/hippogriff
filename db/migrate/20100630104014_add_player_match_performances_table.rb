class AddPlayerMatchPerformancesTable < ActiveRecord::Migration
  def self.up
    create_table :player_match_performances do |t|
      t.integer  :match_id, :player_id
      t.boolean  :player_played, :player_started
      t.integer  :player_shots, :player_goals, :player_assists, :player_penalty_misses, :player_yellow_card, :player_red_card
    end
  end

  def self.down
    drop_table  :player_match_performances
  end
end
