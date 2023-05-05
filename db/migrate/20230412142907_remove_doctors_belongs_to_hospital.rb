# frozen_string_literal: true

class RemoveDoctorsBelongsToHospital < ActiveRecord::Migration[7.0]
  def change
    remove_belongs_to :doctors, :hospital
  end
end
