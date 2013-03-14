# == Schema Information
#
# Table name: person_name
#
#  person_name_id     :integer          not null, primary key
#  preferred          :integer          default(0), not null
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
#  voided             :integer          default(0), not null
#  voided_by          :integer
#  date_voided        :datetime
#  void_reason        :string(255)
#  changed_by         :integer
#  date_changed       :datetime
#  uuid               :string(38)       not null
#

require 'test_helper'

class AncPersonNameTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
