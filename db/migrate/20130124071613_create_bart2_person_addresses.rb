class CreateBart2PersonAddresses < ActiveRecord::Migration
  def self.up
    create_table :bart2_person_addresses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bart2_person_addresses
  end
end
