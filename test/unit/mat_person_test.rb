# == Schema Information
#
# Table name: person
#
#  person_id           :integer          not null, primary key
#  gender              :string(50)       default("")
#  birthdate           :date
#  birthdate_estimated :boolean
#  dead                :boolean          default(FALSE), not null
#  death_date          :datetime
#  cause_of_death      :integer
#  creator             :integer          default(0), not null
#  date_created        :datetime         not null
#  changed_by          :integer
#  date_changed        :datetime
#  voided              :boolean          default(FALSE), not null
#  voided_by           :integer
#  date_voided         :datetime
#  void_reason         :string(255)
#

require 'test_helper'

class MatPersonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
