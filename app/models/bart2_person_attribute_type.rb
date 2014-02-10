# == Schema Information
#
# Table name: person_attribute_type
#
#  person_attribute_type_id :integer          not null, primary key
#  name                     :string(50)       default(""), not null
#  description              :text             default(""), not null
#  format                   :string(50)
#  foreign_key              :integer
#  searchable               :integer          default(0), not null
#  creator                  :integer          default(0), not null
#  date_created             :datetime         not null
#  changed_by               :integer
#  date_changed             :datetime
#  retired                  :integer          default(0), not null
#  retired_by               :integer
#  date_retired             :datetime
#  retire_reason            :string(255)
#  edit_privilege           :string(255)
#  uuid                     :string(38)       not null
#  sort_weight              :float
#

class Bart2PersonAttributeType < ActiveRecord::Base
  establish_connection "openmrs_bart2_#{Rails.env}"
  self.table_name = 'person_attribute_type'
  self.primary_key = 'person_attribute_type_id'
  has_many :person_attributes, :class_name => 'Bart2PersonAttribute', :conditions => {:voided => 0}
end
