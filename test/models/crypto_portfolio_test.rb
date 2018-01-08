# == Schema Information
#
# Table name: crypto_portfolios
#
#  id         :integer          not null, primary key
#  user_id    :string
#  holdings   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CryptoPortfolioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
