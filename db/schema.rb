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

ActiveRecord::Schema.define(:version => 20100721191917) do

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
    t.integer "home_team_possession"
    t.integer "home_team_yellow_cards"
    t.integer "home_team_red_cards"
    t.integer "home_team_total_shots"
    t.integer "home_team_shots_on_target"
    t.string  "home_team_result"
    t.integer "away_team_goals"
    t.integer "away_team_possession"
    t.integer "away_team_yellow_cards"
    t.integer "away_team_red_cards"
    t.integer "away_team_total_shots"
    t.integer "away_team_shots_on_target"
    t.string  "away_team_result"
    t.integer "home_team_fouls"
    t.integer "away_team_fouls"
  end

  create_table "matches", :force => true do |t|
    t.integer "year"
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.date    "date"
    t.integer "gameweek"
    t.boolean "is_played"
    t.string  "home_team_type"
    t.string  "away_team_type"
  end

  create_table "player_match_performances", :force => true do |t|
    t.integer "match_id"
    t.integer "player_id"
    t.boolean "played"
    t.boolean "started"
    t.integer "shots"
    t.integer "goals"
    t.integer "assists"
    t.integer "penalty_misses"
    t.integer "yellow_card"
    t.integer "red_card"
  end

  create_table "players", :force => true do |t|
    t.string  "name"
    t.string  "team"
    t.string  "country"
    t.integer "cost"
    t.string  "type"
    t.integer "team_id"
  end

  create_table "teams", :force => true do |t|
    t.string  "name"
    t.string  "home_stadium"
    t.integer "capacity"
    t.string  "nickname"
    t.integer "last_year_position"
  end

end
