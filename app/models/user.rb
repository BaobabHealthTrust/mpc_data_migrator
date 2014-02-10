# == Schema Information
#
# Table name: users
#
#  user_id              :integer          not null
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

class User < ActiveRecord::Base
  attr_reader :password
  attr_accessor :password_confirmation
  cattr_accessor :current_user

  belongs_to :site

  delegate :name,
      :to        => :site,
      :prefix    => true,
      :allow_nil => true

  def has_role?(role_name)
    true
  end

  def password_matches?(plain_password)
    not plain_password.nil? and self.password == plain_password
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  rescue BCrypt::Errors::InvalidHash
    Rails.logger.error "The password_hash attribute of User[#{self.name}] does not contain a valid BCrypt Hash."
    return nil
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  # returns a new password wor a human user
  def self.new_password
    Array.new(10).map { (65 + rand(58)).chr }.join
  end

  # returns a new user name suitable for use as a
  # site API key
  def self.new_api_key
    ActiveSupport::SecureRandom.hex(24)
  end

  # returns a new password suitable for use as a
  # site password for authentication with the API key
  def self.new_api_password
    ActiveSupport::SecureRandom.hex(24)
  end

end
