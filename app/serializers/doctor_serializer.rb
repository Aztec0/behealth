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
      hash[:feedbacks] = object.doctors_feedbacks
    end
    hash
  end
end