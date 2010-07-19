class Match < ActiveRecord::Base
  has_one    :match_result, :dependent => :destroy
  belongs_to :match_home_team, :polymorphic => true
  belongs_to :match_away_team, :polymorphic => true
end
