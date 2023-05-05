# frozen_string_literal: true

# == Schema Information
#
# Table name: hospitals
#
#  id         :bigint           not null, primary key
#  address    :string
#  city       :string
#  name       :string
#  region     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Hospital < ApplicationRecord
  has_many :doctors
  has_many :tags, as: :tagable

  # def self.tagged_with(name)
  #   Tag.find_by!(tag_name: name).hospitals
  # end
  #
  # def self.tag_counts
  #   Tag.select('tags.*, count(tagable.tag_id) as count').joins(:tagable).group('tagable.tag_id')
  # end
  #
  # def tag_list
  #   tags.map(&:tag_name).join(', ')
  # end
  #
  # def tag_list=(names)
  #   self.tags = names.split(',').map do |n|
  #     Tag.where(tag_name: n.strip, tagable: Hospital.first).first_or_create!
  #   end
  # end
end
