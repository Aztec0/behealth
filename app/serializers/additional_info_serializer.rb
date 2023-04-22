class AdditionalInfoSerializer < ActiveModel::Serializer
  attributes :address, :work_place, :preference_categories

  def address
    PatientAddressSerializer.new(object.patient_address).attributes if object.patient_address.present?
  end

  def work_place
    PatientWorkSerializer.new(object.patient_work).attributes if object.patient_work.present?
  end

  def preference_categories
    nil
  end
end
