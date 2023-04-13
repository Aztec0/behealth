# == Schema Information
#
# Table name: pasports
#
#  id         :bigint           not null, primary key
#  date       :date
#  issued_by  :string
#  number     :string
#  series     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Pasport, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
