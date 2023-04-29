# frozen_string_literal: true

class AddReferenceHospitalToDoctor < ActiveRecord::Migration[7.0]
  def change
    add_reference :doctors, :hospital, foreign_key: { to_table: :hospitals, on_delete: :nullify }
  end
end
