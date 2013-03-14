# == Schema Information
#
# Table name: person
#
#  person_id           :integer          not null, primary key
#  gender              :string(50)       default("")
#  birthdate           :date
#  birthdate_estimated :boolean
#  dead                :boolean          default(FALSE), not null
#  death_date          :datetime
#  cause_of_death      :integer
#  creator             :integer          default(0), not null
#  date_created        :datetime         not null
#  changed_by          :integer
#  date_changed        :datetime
#  voided              :boolean          default(FALSE), not null
#  voided_by           :integer
#  date_voided         :datetime
#  void_reason         :string(255)
#

class MatPerson < ActiveRecord::Base
  establish_connection "openmrs_mat_#{Rails.env}"
  self.table_name = 'person'
  self.primary_key = 'person_id'

  has_one :patient,:class_name => 'MatPatient',:foreign_key => :patient_id, :dependent => :destroy, :conditions => {:voided => 0}
  has_many :names, :class_name => 'MatPersonName', :foreign_key => :person_id, :dependent => :destroy, :order => 'person_name.preferred DESC', :conditions => {:voided => 0}
  has_many :addresses, :class_name => 'MatPersonAddress', :foreign_key => :person_id, :dependent => :destroy, :order => 'person_address.preferred DESC', :conditions => {:voided => 0}
  has_many :person_attributes, :class_name => 'MatPersonAttribute', :foreign_key => :person_id, :conditions => {:voided => 0}
end
