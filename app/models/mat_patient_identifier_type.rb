# == Schema Information
#
# Table name: patient_identifier_type
#
#  patient_identifier_type_id :integer          not null, primary key
#  name                       :string(50)       default(""), not null
#  description                :text             default(""), not null
#  format                     :string(50)
#  check_digit                :boolean          default(FALSE), not null
#  creator                    :integer          default(0), not null
#  date_created               :datetime         not null
#  required                   :boolean          default(FALSE), not null
#  format_description         :string(255)
#  validator                  :string(200)
#  retired                    :boolean          default(FALSE), not null
#  retired_by                 :integer
#  date_retired               :datetime
#  retire_reason              :string(255)
#

class MatPatientIdentifierType < ActiveRecord::Base
  establish_connection "openmrs_mat_#{Rails.env}"
  self.table_name = 'patient_identifier_type'
  self.primary_key = 'patient_identifier_type_id'
  belongs_to :patient, :class_name => "MatPatient",
             :foreign_key => :patient_id, :conditions => {:voided => 0}
end
