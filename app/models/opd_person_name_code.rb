# == Schema Information
#
# Table name: person_name_code
#
#  person_name_code_id     :integer          not null, primary key
#  person_name_id          :integer
#  given_name_code         :string(50)
#  middle_name_code        :string(50)
#  family_name_code        :string(50)
#  family_name2_code       :string(50)
#  family_name_suffix_code :string(50)
#

class OpdPersonNameCode < ActiveRecord::Base
  establish_connection "openmrs_opd_#{Rails.env}"
  self.table_name = 'person_name_code'
  self.primary_key = 'person_name_code_id'
  belongs_to :person_name,:class_name => 'OpdPersonName', :conditions => {:voided => 0}
end
