class RenameColumns < ActiveRecord::Migration
  def self.up
    # TEAMS
    rename_column :teams, :team_name,               :name
    rename_column :teams, :team_home_stadium,       :home_stadium
    rename_column :teams, :team_capacity,           :capacity
    rename_column :teams, :team_nickname,           :nickname
    rename_column :teams, :team_last_year_position, :last_year_position
    # PLAYERS
    rename_column :players, :player_name,           :name
    rename_column :players, :player_team,           :team
    rename_column :players, :player_country,        :country
    rename_column :players, :player_cost,           :cost
    rename_column :players, :player_type,           :type
    # MATCHES
    rename_column :matches, :match_year,            :year
    rename_column :matches, :match_home_team_id,    :home_team_id
    rename_column :matches, :match_away_team_id,    :away_team_id
    rename_column :matches, :match_home_team_type,  :home_team_type
    rename_column :matches, :match_away_team_type,  :away_team_type
    rename_column :matches, :match_date,            :date
    rename_column :matches, :match_gameweek,        :gameweek
    rename_column :matches, :match_is_played,       :is_played
    # MATCH PERFORMANCES
    rename_column :player_match_performances, :player_played,               :played
    rename_column :player_match_performances, :player_started,              :started
    rename_column :player_match_performances, :player_shots,                :shots
    rename_column :player_match_performances, :player_goals,                :goals
    rename_column :player_match_performances, :player_assists,              :assists
    rename_column :player_match_performances, :player_penalty_misses,       :penalty_misses
    rename_column :player_match_performances, :player_yellow_card,          :yellow_card
    rename_column :player_match_performances, :player_red_card,             :red_card
  end

  def self.down
    # TEAMS
    rename_column :teams, :name,               :team_name
    rename_column :teams, :stadium,            :team_home_stadium
    rename_column :teams, :capacity,           :team_capacity
    rename_column :teams, :nickname,           :team_nickname
    rename_column :teams, :last_year_position, :team_last_year_position
    # PLAYERS
    rename_column :players, :name,           :player_name
    rename_column :players, :team,           :player_team
    rename_column :players, :country,        :player_country
    rename_column :players, :cost,           :player_cost
    rename_column :players, :type,           :player_type
    # MATCHES
    rename_column :matches, :year,            :match_year
    rename_column :matches, :home_team_id,    :match_home_team_id
    rename_column :matches, :away_team_id,    :match_away_team_id
    rename_column :matches, :home_team_type,  :match_home_team_type
    rename_column :matches, :away_team_type,  :match_away_team_type
    rename_column :matches, :date,            :match_date
    rename_column :matches, :gameweek,        :match_gameweek
    rename_column :matches, :is_played,       :match_is_played
    # MATCH PERFORMANCES
    rename_column :player_match_performances, :played,               :player_played
    rename_column :player_match_performances, :started,              :player_started
    rename_column :player_match_performances, :shots,                :player_shots
    rename_column :player_match_performances, :goals,                :player_goals
    rename_column :player_match_performances, :assists,              :player_assists
    rename_column :player_match_performances, :penalty_misses,       :player_penalty_misses
    rename_column :player_match_performances, :yellow_card,          :player_yellow_card
    rename_column :player_match_performances, :red_card,             :player_red_card
  end
end
