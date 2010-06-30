class AddFixturesTable < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer  :match_year
      t.integer  :match_home_team_id
      t.integer  :match_away_team_id
      t.date     :match_date
      t.integer  :match_gameweek
      t.boolean  :match_is_played
    end
  end

  def self.down
    drop_table :matches
  end
end
