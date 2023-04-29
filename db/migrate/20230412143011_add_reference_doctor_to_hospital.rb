# frozen_string_literal: true

class AddReferenceDoctorToHospital < ActiveRecord::Migration[7.0]
  def change
    add_reference :hospitals, :doctor, foreign_key: { to_table: :doctors, on_delete: :nullify }
  end
end
