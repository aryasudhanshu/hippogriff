class AddFixtureResultTable < ActiveRecord::Migration
  def self.up
    create_table :match_results do |t|
      t.integer  :match_id            # this is the foreign key for table matches
      t.integer  :home_team_goals, :home_team_posession, :home_team_yellow_cards, :home_team_red_cards, :home_team_total_shots, :home_team_shots_on_target, :home_team_result
      t.integer  :away_team_goals, :away_team_posession, :away_team_yellow_cards, :away_team_red_cards, :away_team_total_shots, :away_team_shots_on_target, :away_team_result      
    end
  end

  def self.down
    drop_table   :match_results
  end
end
