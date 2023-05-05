# frozen_string_literal: true

class PatientPolicy < ApplicationPolicy
  def show?
    user.role == 'admin'
  end

  def create?
    user.role == 'admin' || user.role == 'patient'
  end

  def update?
    user.role == 'admin' || user.role == 'patient'
  end

  def delete?
    user.role == 'admin'
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
