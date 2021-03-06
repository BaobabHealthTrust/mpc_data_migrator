# == Schema Information
#
# Table name: person_attribute
#
#  person_attribute_id      :integer          not null, primary key
#  person_id                :integer          default(0), not null
#  value                    :string(50)       default(""), not null
#  person_attribute_type_id :integer          default(0), not null
#  creator                  :integer          default(0), not null
#  date_created             :datetime         not null
#  changed_by               :integer
#  date_changed             :datetime
#  voided                   :integer          default(0), not null
#  voided_by                :integer
#  date_voided              :datetime
#  void_reason              :string(255)
#  uuid                     :string(38)       not null
#

require 'test_helper'

class AncPersonAttributeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
