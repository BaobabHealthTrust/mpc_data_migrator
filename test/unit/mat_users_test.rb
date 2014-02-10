# == Schema Information
#
# Table name: users
#
#  user_id         :integer          not null, primary key
#  system_id       :string(50)       default(""), not null
#  username        :string(50)
#  password        :string(50)
#  salt            :string(50)
#  secret_question :string(255)
#  secret_answer   :string(255)
#  creator         :integer          default(0), not null
#  date_created    :datetime         not null
#  changed_by      :integer
#  date_changed    :datetime
#  voided          :boolean          default(FALSE), not null
#  voided_by       :integer
#  date_voided     :datetime
#  void_reason     :string(255)
#

require 'test_helper'

class MatUsersTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
