class CreateMatPersonAddresses < ActiveRecord::Migration
  def self.up
    create_table :mat_person_addresses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :mat_person_addresses
  end
end
