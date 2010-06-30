class CreatePlayerMatchPerformances < ActiveRecord::Migration
  def self.up
    create_table :player_match_performances do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :player_match_performances
  end
end
