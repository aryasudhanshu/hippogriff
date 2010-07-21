class Team < ActiveRecord::Base
  has_many :matches, :as => :home_team
  has_many :matches, :as => :away_team
  has_many :players,          :dependent => :destroy
  has_many :league_positions, :dependent => :destroy  

  
end
