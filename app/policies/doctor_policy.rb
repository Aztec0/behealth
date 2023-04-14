# frozen_string_literal: true

class DoctorPolicy < ApplicationPolicy

  def index?
    user.role == 'doctor'
  end

  def create?
    user.role == 'doctor'
  end

  def delete?
    user.role == 'doctor'
  end


  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end