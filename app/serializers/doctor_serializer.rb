# frozen_string_literal: true

# == Schema Information
#
# Table name: doctors
#
#  id                   :bigint           not null, primary key
#  birthday             :date
#  email                :string
#  name                 :string
#  password_digest      :string
#  phone                :bigint
#  position             :string
#  rating               :integer          default(0)
#  reset_password_token :string
#  role                 :integer          default("doctor")
#  surname              :string
#  token_sent_at        :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  head_doctor_id       :bigint
#  hospital_id          :bigint
# Indexes
#
#  index_doctors_on_head_doctor_id  (head_doctor_id)
#  index_doctors_on_hospital_id     (hospital_id)
#
# Foreign Keys
#
#  fk_rails_...  (head_doctor_id => doctors.id)
#  fk_rails_...  (hospital_id => hospitals.id) ON DELETE => nullify
#
class DoctorSerializer < ActiveModel::Serializer
  attributes :full_name, :position, :hospital_name, :rating

  def full_name
    "#{object.name} #{object.surname}"
  end

  def hospital_name
    object.hospital.name if object.hospital.present?
  end

  def attributes(*args)
    hash = super
    if @instance_options[:action] == :index
      hash[:id] = object.id
      hash[:hospital_city] = object.hospital.city
      hash[:hospital_adress] = object.hospital.address
    elsif @instance_options[:action] == :show
      hash[:hospital_city] = object.hospital.city
      hash[:hospital_region] = object.hospital.region
      hash[:hospital_adress] = object.hospital.address
      hash[:phone] = object.phone
      hash[:age] = ((Time.zone.now - object.birthday.to_time) / 1.year.seconds).floor
      hash[:feedbacks] = object.feedbacks
    end
    hash
  end
end
