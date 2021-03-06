class AddTeamsTable < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string   :team_name
      t.string   :team_home_stadium
      t.integer  :team_capacity
      t.string   :team_nickname
      t.integer  :team_last_year_position
    end
  end

  def self.down
    drop_table   :teams
  end
end
