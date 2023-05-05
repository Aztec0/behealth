# frozen_string_literal: true

class RemoveHeadDoctorFromDoctors < ActiveRecord::Migration[7.0]
  def change
    remove_reference :doctors, :head_doctor
  end
end
