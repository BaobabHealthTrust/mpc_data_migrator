# == Schema Information
#
# Table name: person_address
#
#  person_address_id :integer          not null, primary key
#  person_id         :integer
#  preferred         :boolean          default(FALSE), not null
#  address1          :string(50)
#  address2          :string(50)
#  city_village      :string(50)
#  state_province    :string(50)
#  postal_code       :string(50)
#  country           :string(50)
#  latitude          :string(50)
#  longitude         :string(50)
#  creator           :integer          default(0), not null
#  date_created      :datetime         not null
#  voided            :boolean          default(FALSE), not null
#  voided_by         :integer
#  date_voided       :datetime
#  void_reason       :string(255)
#  county_district   :string(50)
#  neighborhood_cell :string(50)
#  region            :string(50)
#  subregion         :string(50)
#  township_division :string(50)
#

class MatPersonAddress < ActiveRecord::Base
  establish_connection "openmrs_mat_#{Rails.env}"
  self.table_name = 'person_address'
  self.primary_key = 'person_address_id'
  belongs_to :person, :class_name => 'MatPerson', :foreign_key => :person_id, :conditions => {:voided => 0}
end
