# == Schema Information
#
# Table name: doctors
#
#  id                     :bigint           not null, primary key
#  birthday               :date
#  email                  :string
#  name                   :string
#  password_digest        :string
#  phone                  :bigint
#  position               :string
#  rating                 :integer          default(0)
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("doctor")
#  surname                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  hospital_id            :bigint
#
# Indexes
#
#  index_doctors_on_hospital_id  (hospital_id)
#
# Foreign Keys
#
#  fk_rails_...  (hospital_id => hospitals.id)
#
class DoctorSerializer < ActiveModel::Serializer
  attributes :full_name, :position, :hospital, :rating

  def full_name
    "#{object.name} #{object.surname}"
  end

  def hospital
    object.hospital.name
  end

  def attributes(*args)
    hash = super
    if @instance_options[:action] == :index
      hash[:id] = object.id
    elsif @instance_options[:action] == :show
      hash[:age] =  Date.today.year - object.birthday.year - ((Date.today.month > object.birthday.month ||
        (Date.today.month == object.birthday.month && Date.today.day >= object.birthday.day)) ? 0 : 1)
      hash[:feedbacks] = object.feedbacks
    end
    hash
  end
end
