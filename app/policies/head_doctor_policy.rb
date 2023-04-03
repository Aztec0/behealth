# frozen_string_literal: true

class HeadDoctorPolicy < DoctorPolicy
  def index?
    user.head_doctor?
  end

  def create_doctor?
    user.head_doctor?
  end

  def create_hospital?
    user.head_doctor?
  end

  def delete_doctor?
    user.head_doctor?
  end

  def canceled_appointments?
    user.head_doctor?
  end
end
