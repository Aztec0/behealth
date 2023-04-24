# frozen_string_literal: true

class AddPatientIdToPatientWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_works, :patient_id, :bigint, null: false
  end
end
