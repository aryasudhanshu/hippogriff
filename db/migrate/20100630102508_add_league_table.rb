class AddLeagueTable < ActiveRecord::Migration
  def self.up
    create_table :league_positions do |t|
      t.integer  :year
      t.integer  :position
      t.integer  :team_id
      t.integer  :wins, :draws, :losses, :gs, :ga, :gd
      t.integer  :points
    end
  end

  def self.down
    drop_table   :league_positions
  end
end
