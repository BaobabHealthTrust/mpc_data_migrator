# == Schema Information
#
# Table name: patient_identifier_type
#
#  patient_identifier_type_id :integer          not null, primary key
#  name                       :string(50)       default(""), not null
#  description                :text             default(""), not null
#  format                     :string(50)
#  check_digit                :integer          default(0), not null
#  creator                    :integer          default(0), not null
#  date_created               :datetime         not null
#  required                   :integer          default(0), not null
#  format_description         :string(255)
#  validator                  :string(200)
#  retired                    :integer          default(0), not null
#  retired_by                 :integer
#  date_retired               :datetime
#  retire_reason              :string(255)
#  uuid                       :string(38)       not null
#

class Bart2PatientIdentifierType < ActiveRecord::Base
  establish_connection "openmrs_bart2_#{Rails.env}"
  self.table_name = 'patient_identifier_type'
  self.primary_key = 'patient_identifier_type_id'
end
