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

class Currency < ApplicationRecord

  has_many :snapshots, foreign_key: :cmc_id, primary_key: :cmc_id
end
