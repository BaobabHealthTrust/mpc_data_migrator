class CreatePersonNameCodes < ActiveRecord::Migration
  def self.up
    create_table :person_name_codes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :person_name_codes
  end
end
