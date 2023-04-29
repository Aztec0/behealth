# frozen_string_literal: true

# == Schema Information
#
# Table name: id_cards
#
#  id         :bigint           not null, primary key
#  date       :date
#  issued_by  :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe IdCard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
