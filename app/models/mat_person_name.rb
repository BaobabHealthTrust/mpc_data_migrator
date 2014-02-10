# == Schema Information
#
# Table name: person_name
#
#  person_name_id     :integer          not null, primary key
#  preferred          :boolean          default(FALSE), not null
#  person_id          :integer
#  prefix             :string(50)
#  given_name         :string(50)
#  middle_name        :string(50)
#  family_name_prefix :string(50)
#  family_name        :string(50)
#  family_name2       :string(50)
#  family_name_suffix :string(50)
#  degree             :string(50)
#  creator            :integer          default(0), not null
#  date_created       :datetime         not null
#  voided             :boolean          default(FALSE), not null
#  voided_by          :integer
#  date_voided        :datetime
#  void_reason        :string(255)
#  changed_by         :integer
#  date_changed       :datetime
#

class MatPersonName < ActiveRecord::Base
  establish_connection "openmrs_mat_#{Rails.env}"
  self.table_name = 'person_name'
  self.primary_key = 'person_name_id'

  belongs_to :person, :class_name => 'MatPerson', :foreign_key => :person_id, :conditions => {:voided => 0}
  has_one :person_name_code, :class_name => 'MatPersonNameCode', :foreign_key => :person_name_id

  def before_save
    self.build_person_name_code(
      :person_name_id => self.person_name_id,
      :given_name_code => (self.given_name || '').soundex,
      :middle_name_code => (self.middle_name || '').soundex,
      :family_name_code => (self.family_name || '').soundex,
      :family_name2_code => (self.family_name2 || '').soundex,
      :family_name_suffix_code => (self.family_name_suffix || '').soundex)
  end
end
