class Team < ActiveRecord::Base
  has_many :matches, :as => :match_home_team
  has_many :matches, :as => :match_away_team
  has_many :players,          :dependent => :destroy
  has_many :league_positions, :dependent => :destroy  
end
