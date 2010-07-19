class FixMatchesTableForPolymorphicAssociation < ActiveRecord::Migration
  def self.up
    add_column :matches, :match_home_team_type, :string
    add_column :matches, :match_away_team_type, :string
  end

  def self.down
    remove_column :matches, :match_home_team_type, :string
    remove_column :matches, :match_away_team_type, :string
  end
end
