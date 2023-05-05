# frozen_string_literal: true

class CreatePatientWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_works do |t|
      t.string :work_type, null: false
      t.string :place, null: false
      t.string :position, null: false

      t.timestamps
    end
  end
end
