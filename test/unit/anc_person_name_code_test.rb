# == Schema Information
#
# Table name: person_name_code
#
#  person_name_code_id     :integer          not null, primary key
#  person_name_id          :integer
#  given_name_code         :string(50)
#  middle_name_code        :string(50)
#  family_name_code        :string(50)
#  family_name2_code       :string(50)
#  family_name_suffix_code :string(50)
#

require 'test_helper'

class AncPersonNameCodeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
