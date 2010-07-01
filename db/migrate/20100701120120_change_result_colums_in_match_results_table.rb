class ChangeResultColumsInMatchResultsTable < ActiveRecord::Migration
  def self.up
    change_table :match_results do |t|
      t.change :home_team_result, :string
      t.change :away_team_result, :string
    end
  end

  def self.down
  end
end
