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
class HospitalSerializer < ActiveModel::Serializer
  attributes :id, :region, :city, :address, :name, :rating

  def rating
    object.rating.round(2)
  end
end
