# == Schema Information
#
# Table name: patient_identifier
#
#  patient_id      :integer          default(0), not null, primary key
#  identifier      :string(50)       default(""), not null
#  identifier_type :integer          default(0), not null
#  preferred       :integer          default(0), not null
#  location_id     :integer          default(0), not null
#  creator         :integer          default(0), not null
#  date_created    :datetime         not null
#  voided          :boolean          default(FALSE), not null
#  voided_by       :integer
#  date_voided     :datetime
#  void_reason     :string(255)
#

require 'test_helper'

class MatPatientIdentifierTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
