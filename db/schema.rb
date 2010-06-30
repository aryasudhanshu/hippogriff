# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100630104014) do

  create_table "league_positions", :force => true do |t|
    t.integer "year"
    t.integer "position"
    t.integer "team_id"
    t.integer "wins"
    t.integer "draws"
    t.integer "losses"
    t.integer "gs"
    t.integer "ga"
    t.integer "gd"
    t.integer "points"
  end

  create_table "match_results", :force => true do |t|
    t.integer "match_id"
    t.integer "home_team_goals"
    t.integer "home_team_posession"
    t.integer "home_team_yellow_cards"
    t.integer "home_team_red_cards"
    t.integer "home_team_total_shots"
    t.integer "home_team_shots_on_target"
    t.integer "home_team_result"
    t.integer "away_team_goals"
    t.integer "away_team_posession"
    t.integer "away_team_yellow_cards"
    t.integer "away_team_red_cards"
    t.integer "away_team_total_shots"
    t.integer "away_team_shots_on_target"
    t.integer "away_team_result"
  end

  create_table "matches", :force => true do |t|
    t.integer "match_year"
    t.integer "match_home_team_id"
    t.integer "match_away_team_id"
    t.date    "match_date"
    t.integer "match_gameweek"
    t.boolean "match_is_played"
  end

  create_table "player_match_performances", :force => true do |t|
    t.integer "match_id"
    t.integer "player_id"
    t.boolean "player_played"
    t.boolean "player_started"
    t.integer "player_shots"
    t.integer "player_goals"
    t.integer "player_assists"
    t.integer "player_penalty_misses"
    t.integer "player_yellow_card"
    t.integer "player_red_card"
  end

  create_table "players", :force => true do |t|
    t.string  "player_name"
    t.string  "player_team"
    t.string  "player_country"
    t.integer "player_cost"
    t.string  "player_type"
    t.integer "team_id"
  end

  create_table "teams", :force => true do |t|
    t.string  "team_name"
    t.string  "team_home_stadium"
    t.integer "team_capacity"
    t.string  "team_nickname"
    t.integer "team_last_year_position"
  end

end
