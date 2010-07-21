class Match < ActiveRecord::Base
  has_one    :match_result, :dependent => :destroy
  belongs_to :home_team, :polymorphic => true
  belongs_to :away_team, :polymorphic => true
end
