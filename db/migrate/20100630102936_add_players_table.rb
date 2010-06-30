class AddPlayersTable < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string   :player_name
      t.string   :player_team
      t.string   :player_country
      t.integer  :player_cost
      t.string   :player_type
      t.integer  :team_id
    end
  end

  def self.down
    drop_table   :players
  end
end
