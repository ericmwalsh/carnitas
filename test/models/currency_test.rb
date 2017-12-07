# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  cmc_id     :string
#  name       :string
#  symbol     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
