# frozen_string_literal: true

class DoctorPolicy < ApplicationPolicy

  def index?
    user.role == 'head_doctor'
  end

  def create_doctor?
    user.role == 'head_doctor'
  end

  def create_hospital?
    user.role == 'head_doctor'
  end

  def delete?
    user.role == 'head_doctor'
  end

  def staff_appointments?
    user.role == 'head_doctor'
  end

  def list_doctor_by_hospital?
    user.role == 'head_doctor'
  end


  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end