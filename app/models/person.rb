class Person < ActiveRecord::Base
  # dummy accessors
  attr_accessor :status, :status_message

  has_many :legacy_national_ids,:class_name => 'LegacyNationalIds', 
           :foreign_key => 'person_id'
  has_many :person_name_codes,:class_name => 'PersonNameCode',
           :foreign_key => 'person_id'

  belongs_to :creator,
      :class_name => 'User'
  belongs_to :creator_site,
      :class_name => 'Site'

  after_save :create_person_name_code
  
  protected

  def set_version_number
    self.version_number = Guid.new.to_s
  end
  
  def create_person_name_code
    PersonNameCode.create_name_code(self)
  end

end
