# frozen_string_literal: true

# == Schema Information
#
# Table name: hospitals
#
#  id         :bigint           not null, primary key
#  address    :string
#  city       :string
#  name       :string
#  rating     :float            default(0.0)
#  region     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Hospital < ApplicationRecord
  has_many :doctors
  has_many :tags, as: :tagable
  has_many :feedbacks, as: :doctorable
end
