# frozen_string_literal: true

class DoctorByHospitalSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :second_name, :last_name, :position, :age, :phone, :second_phone, :email, :second_email,
             :admission_price, :hospital, :rating, :feedbacks
  has_one :hospital

  def age
    object.birthday ? ((Time.zone.now - object.birthday.to_time) / 1.year.seconds).floor : nil
  end

  def rating
    object.rating.round(2)
  end
end
