# == Schema Information
#
# Table name: patient_identifier
#
#  patient_id      :integer          default(0), not null, primary key
#  identifier      :string(50)       default(""), not null
#  identifier_type :integer          default(0), not null
#  preferred       :integer          default(0), not null
#  location_id     :integer          default(0), not null
#  creator         :integer          default(0), not null
#  date_created    :datetime         not null
#  voided          :boolean          default(FALSE), not null
#  voided_by       :integer
#  date_voided     :datetime
#  void_reason     :string(255)
#

class MatPatientIdentifier < ActiveRecord::Base
  establish_connection "openmrs_mat_#{Rails.env}"
  self.table_name = 'patient_identifier'
  self.primary_key = 'patient_id'
  belongs_to :patient, :class_name => "MatPatient",
             :foreign_key => :patient_id, :conditions => {:voided => 0}
end
