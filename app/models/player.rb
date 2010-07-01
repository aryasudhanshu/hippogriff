class Player < ActiveRecord::Base
  has_and_belongs_to_many :player_match_performances
end
