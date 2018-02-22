# == Schema Information
#
# Table name: api_keys
#
#  id         :integer          not null, primary key
#  user_id    :string           not null
#  provider   :string           not null
#  key        :string           not null
#  secret     :string           not null
#  encryptor  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  passphrase :string
#  is_valid   :boolean          default(TRUE), not null
#
# Indexes
#
#  index_api_keys_on_user_id_and_is_valid  (user_id,is_valid)
#  index_api_keys_on_user_id_and_key       (user_id,key) UNIQUE
#

require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
