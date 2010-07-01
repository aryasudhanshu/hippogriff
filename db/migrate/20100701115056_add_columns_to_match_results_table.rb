class AddColumnsToMatchResultsTable < ActiveRecord::Migration
  def self.up
    add_column :match_results, :home_team_fouls, :integer
    add_column :match_results, :away_team_fouls, :integer
  end

  def self.down
    remove_column :match_results, :home_team_fouls
    remove_column :match_results, :away_team_fouls
  end
end
