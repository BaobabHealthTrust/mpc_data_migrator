class Bart2PatientIdentifierType < ActiveRecord::Base
  establish_connection "openmrs_bart2_#{Rails.env}"
  self.table_name = 'patient_identifier_type'
  self.primary_key = 'patient_identifier_type_id'
end
