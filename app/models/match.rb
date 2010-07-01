class Match < ActiveRecord::Base
  has_one   :match_result, :dependent => :destroy
end
