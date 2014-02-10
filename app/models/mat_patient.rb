# == Schema Information
#
# Table name: patient
#
#  patient_id   :integer          not null, primary key
#  tribe        :integer
#  creator      :integer          default(0), not null
#  date_created :datetime         not null
#  changed_by   :integer
#  date_changed :datetime
#  voided       :boolean          default(FALSE), not null
#  voided_by    :integer
#  date_voided  :datetime
#  void_reason  :string(255)
#

class MatPatient < ActiveRecord::Base
  establish_connection "openmrs_mat_#{Rails.env}"
  self.table_name = 'patient'
  self.primary_key = 'patient_id'
  has_one :person, :class_name => 'MatPerson', :foreign_key => :person_id, :conditions => {:voided => 0}
  has_many :patient_identifiers, :class_name => 'MatPatientIdentifier' , :foreign_key => :patient_id,
      :dependent => :destroy, :conditions => {:voided => 0,:identifier_type => 3}
end
