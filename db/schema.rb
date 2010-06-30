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

ActiveRecord::Schema.define(:version => 20100630094217) do

  create_table "matches", :force => true do |t|
    t.integer "match_year"
    t.integer "match_home_team_id"
    t.integer "match_away_team_id"
    t.date    "match_date"
    t.integer "match_gameweek"
    t.boolean "match_is_played"
  end

  create_table "teams", :force => true do |t|
    t.string  "team_name"
    t.string  "team_home_stadium"
    t.integer "team_capacity"
    t.string  "team_nickname"
    t.integer "team_last_year_position"
  end

end
