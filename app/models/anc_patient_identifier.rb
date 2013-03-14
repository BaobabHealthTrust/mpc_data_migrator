# == Schema Information
#
# Table name: patient_identifier
#
#  patient_identifier_id :integer          not null, primary key
#  patient_id            :integer          default(0), not null
#  identifier            :string(50)       default(""), not null
#  identifier_type       :integer          default(0), not null
#  preferred             :integer          default(0), not null
#  location_id           :integer          default(0), not null
#  creator               :integer          default(0), not null
#  date_created          :datetime         not null
#  voided                :integer          default(0), not null
#  voided_by             :integer
#  date_voided           :datetime
#  void_reason           :string(255)
#  uuid                  :string(38)       not null
#

class AncPatientIdentifier < ActiveRecord::Base
  establish_connection "openmrs_anc_#{Rails.env}"
  self.table_name = 'patient_identifier'
  self.primary_key = 'patient_identifier_id'
  belongs_to :patient, :class_name => "AncPatient",
             :foreign_key => :patient_id, :conditions => {:voided => 0}
end
