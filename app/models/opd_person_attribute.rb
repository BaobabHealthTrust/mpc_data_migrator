# == Schema Information
#
# Table name: person_attribute
#
#  person_attribute_id      :integer          not null, primary key
#  person_id                :integer          default(0), not null
#  value                    :string(50)       default(""), not null
#  person_attribute_type_id :integer          default(0), not null
#  creator                  :integer          default(0), not null
#  date_created             :datetime         not null
#  changed_by               :integer
#  date_changed             :datetime
#  voided                   :integer          default(0), not null
#  voided_by                :integer
#  date_voided              :datetime
#  void_reason              :string(255)
#  uuid                     :string(38)       not null
#

class OpdPersonAttribute < ActiveRecord::Base
  establish_connection "openmrs_opd_#{Rails.env}"
  self.table_name = 'person_attribute'
  self.primary_key = 'person_attribute_id'
  belongs_to :type, :class_name => "OpdPersonAttributeType", :foreign_key => :person_attribute_type_id, :conditions => {:retired => 0}
  belongs_to :person,:class_name => "OpdPerson", :foreign_key => :person_id, :conditions => {:voided => 0}
end
