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

class Bart2PersonNameCode < ActiveRecord::Base
  establish_connection "openmrs_bart2_#{Rails.env}"
  self.table_name = 'person_name_code'
  self.primary_key = 'person_name_code_id'
  belongs_to :person_name,:class_name => 'Bart2PersonName', :conditions => {:voided => 0}
end
