# frozen_string_literal: true

class DoctorPolicy < ApplicationPolicy

  def show?
    user.role == 'admin' || user.role == 'head_doctor'
  end

  def edit?
    user.role == 'admin' || user.role == 'head_doctor'
  end

  def update?
    user.role == 'admin' || user.role == 'head_doctor'
  end

  def create_doctor?
    user.role == 'head_doctor'
  end

  def create?
    user.role == 'admin'
  end

  def delete_doctor?
    user.role == 'head_doctor'
  end

  def delete?
    user.role == 'admin'
  end

  def staff_appointments?
    user.role == 'admin' || user.role == 'head_doctor'
  end

  def list_doctor_by_hospital?
    user.role == 'admin' || user.role == 'head_doctor'
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
