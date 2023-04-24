# == Schema Information
#
# Table name: taggings
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  hospital_id :bigint           not null
#  tag_id      :bigint           not null
#
# Indexes
#
#  index_taggings_on_hospital_id  (hospital_id)
#  index_taggings_on_tag_id       (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (hospital_id => hospitals.id)
#  fk_rails_...  (tag_id => tags.id)
#
require 'rails_helper'

RSpec.describe Tagging, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
