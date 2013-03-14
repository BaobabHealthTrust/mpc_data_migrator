# == Schema Information
#
# Table name: patient_identifier
#
#  patient_identifier_id :integer          not null, primary key
#  patient_id            :integer          default(0), not null
#  identifier            :string(50)       default(""), not null
#  identifier_type       :integer          default(0), not null
#  preferred             :integer          default(0), not null
#  location_id           :integer          default(0), not null
#  creator               :integer          default(0), not null
#  date_created          :datetime         not null
#  voided                :integer          default(0), not null
#  voided_by             :integer
#  date_voided           :datetime
#  void_reason           :string(255)
#  uuid                  :string(38)       not null
#

require 'test_helper'

class AncPatientIdentifierTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
