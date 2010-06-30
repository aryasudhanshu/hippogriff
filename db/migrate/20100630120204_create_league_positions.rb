class CreateLeaguePositions < ActiveRecord::Migration
  def self.up
    create_table :league_positions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :league_positions
  end
end
