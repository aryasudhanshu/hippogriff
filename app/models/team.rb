class Team < ActiveRecord::Base
  has_many :players,          :dependent => :destroy
  has_many :league_positions, :dependent => :destroy  
end
