# == Schema Information
#
# Table name: users
#
#  user_id              :integer          not null, primary key
#  system_id            :string(50)       default(""), not null
#  username             :string(50)
#  password             :string(128)
#  salt                 :string(128)
#  secret_question      :string(255)
#  secret_answer        :string(255)
#  creator              :integer          default(0), not null
#  date_created         :datetime         not null
#  changed_by           :integer
#  date_changed         :datetime
#  person_id            :integer
#  retired              :integer          default(0), not null
#  retired_by           :integer
#  date_retired         :datetime
#  retire_reason        :string(255)
#  uuid                 :string(38)       not null
#  authentication_token :string(255)
#

class OpdUsers < ActiveRecord::Base
  establish_connection "openmrs_opd_#{Rails.env}"
  self.table_name = 'users'
  self.primary_key = 'user_id'
  belongs_to :person, :class_name => 'OpdPerson', :foreign_key => :person_id, :conditions => {:voided => 0}
end
