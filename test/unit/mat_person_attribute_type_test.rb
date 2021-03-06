# == Schema Information
#
# Table name: person_attribute_type
#
#  person_attribute_type_id :integer          not null, primary key
#  name                     :string(50)       default(""), not null
#  description              :text             default(""), not null
#  format                   :string(50)
#  foreign_key              :integer
#  searchable               :boolean          default(FALSE), not null
#  creator                  :integer          default(0), not null
#  date_created             :datetime         not null
#  changed_by               :integer
#  date_changed             :datetime
#  retired                  :boolean          default(FALSE), not null
#  retired_by               :integer
#  date_retired             :datetime
#  retire_reason            :string(255)
#

require 'test_helper'

class MatPersonAttributeTypeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
