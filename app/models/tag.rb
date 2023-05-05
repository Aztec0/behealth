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
class Tag < ApplicationRecord
  belongs_to :tagable, polymorphic: true
end
