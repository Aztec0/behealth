# frozen_string_literal: true

# == Schema Information
#
# Table name: doctors
#
#  id                   :bigint           not null, primary key
#  about                :text
#  admission_price      :decimal(, )
#  birthday             :date
#  email                :string
#  email_confirmed      :boolean          default(TRUE)
#  first_name           :string
#  last_name            :string
#  password_digest      :string
#  phone                :bigint
#  position             :string
#  rating               :integer          default(0)
#  reset_password_token :string
#  role                 :integer          default("doctor")
#  second_email         :string
#  second_name          :string
#  second_phone         :bigint
#  token_sent_at        :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  head_doctor_id       :bigint
#  hospital_id          :bigint
#
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
class DoctorIndexSerializer < ActiveModel::Serializer
  attributes :first_name, :second_name, :last_name, :position, :hospital, :rating
  has_one :hospital

  def rating
    object.rating.round(2)
  end
end
