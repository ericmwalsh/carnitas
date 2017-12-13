# == Schema Information
#
# Table name: cc_snapshots
#
#  id          :integer          not null, primary key
#  symbol      :string
#  close       :float
#  high        :float
#  low         :float
#  open        :float
#  volume_from :float
#  volume_to   :float
#  time        :float
#
# Indexes
#
#  index_cc_snapshots_on_symbol_and_time  (symbol,time) UNIQUE
#

class CcSnapshot < ApplicationRecord
end
