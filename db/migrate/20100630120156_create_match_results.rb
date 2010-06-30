class CreateMatchResults < ActiveRecord::Migration
  def self.up
    create_table :match_results do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :match_results
  end
end
