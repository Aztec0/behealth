# == Schema Information
#
# Table name: tags
#
#  id           :bigint           not null, primary key
#  tag_name     :string
#  tagable_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tagable_id   :bigint           not null
#
# Indexes
#
#  index_tags_on_tagable  (tagable_type,tagable_id)
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
