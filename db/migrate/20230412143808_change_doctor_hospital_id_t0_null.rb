# frozen_string_literal: true

class ChangeDoctorHospitalIdT0Null < ActiveRecord::Migration[7.0]
  def change
    change_column :doctors, :hospital_id, :bigint, null: true
  end
end
