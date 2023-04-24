# frozen_string_literal: true

class HeadDoctorPolicy < ApplicationPolicy
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

  def canceled_appointments?
    user.role == 'head_doctor'
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
