# == Schema Information
#
# Table name: inputs
#
#  id         :integer          not null, primary key
#  user_id    :string           not null
#  symbol     :string           not null
#  amount     :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_inputs_on_user_id_and_symbol  (user_id,symbol) UNIQUE
#

require 'test_helper'

class InputTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
