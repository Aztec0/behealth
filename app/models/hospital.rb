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
#  doctor_id  :bigint
#
# Indexes
#
#  index_hospitals_on_doctor_id  (doctor_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => doctors.id) ON DELETE => nullify
#
class Hospital < ApplicationRecord
  has_many :doctors
  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by!(name: name).hospitals
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  # for ransack searching
  def self.ransackable_attributes(auth_object = nil)
    %w[address city name region doctor_id].freeze
  end

  def self.ransackable_associations(auth_object = nil)
    ['doctors']
  end
end
