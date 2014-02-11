# == Schema Information
#
# Table name: person
#
#  person_id           :integer          not null, primary key
#  gender              :string(50)       default("")
#  birthdate           :date
#  birthdate_estimated :integer          default(0), not null
#  dead                :integer          default(0), not null
#  death_date          :datetime
#  cause_of_death      :integer
#  creator             :integer          default(0), not null
#  date_created        :datetime         not null
#  changed_by          :integer
#  date_changed        :datetime
#  voided              :integer          default(0), not null
#  voided_by           :integer
#  date_voided         :datetime
#  void_reason         :string(255)
#  uuid                :string(38)       not null
#

class OpdPerson < ActiveRecord::Base
  establish_connection "openmrs_opd_#{Rails.env}"
  self.table_name = 'person'
  self.primary_key = 'person_id'

  has_one :patient,:class_name => 'OpdPatient',:foreign_key => :patient_id, :dependent => :destroy, :conditions => {:voided => 0}
  has_many :names, :class_name => 'OpdPersonName', :foreign_key => :person_id, :dependent => :destroy, :order => 'person_name.preferred DESC', :conditions => {:voided => 0}
  has_many :addresses, :class_name => 'OpdPersonAddress', :foreign_key => :person_id, :dependent => :destroy, :order => 'person_address.preferred DESC', :conditions => {:voided => 0}
  has_many :person_attributes, :class_name => 'OpdPersonAttribute', :foreign_key => :person_id, :conditions => {:voided => 0}
end
