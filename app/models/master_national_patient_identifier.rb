# v3 Id: P + Version + Site Code + Sequential Number + Check Digit
# v4 Id: base30(Random Number + Check Digit)
#
class MasterNationalPatientIdentifier < ActiveRecord::Base
  establish_connection "dde_master_#{Rails.env}"
  self.table_name = 'national_patient_identifiers'
  self.primary_key = 'id'
  #belongs_to :person
  belongs_to :assigner,
      :class_name => 'User'
  belongs_to :assigner_site,
      :class_name => 'Site', :foreign_key => 'assigner_site_id'

  validates_presence_of :value, :assigner_site_id

  # don't allow more than one ID to be assigned to any person
  validates_uniqueness_of :person_id,
      :allow_nil => true

  # create the decimal equivalent of the Id value if it has not yet been set
  before_save do |npid|
    if npid.decimal_num.blank?
      num = NationalPatientId.to_decimal(npid.value, 30) / 10
      npid.decimal_num = num
    end
  end
  
end
