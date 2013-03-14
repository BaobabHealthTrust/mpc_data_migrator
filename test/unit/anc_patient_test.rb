# == Schema Information
#
# Table name: patient
#
#  patient_id   :integer          not null, primary key
#  tribe        :integer
#  creator      :integer          default(0), not null
#  date_created :datetime         not null
#  changed_by   :integer
#  date_changed :datetime
#  voided       :integer          default(0), not null
#  voided_by    :integer
#  date_voided  :datetime
#  void_reason  :string(255)
#

require 'test_helper'

class AncPatientTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
