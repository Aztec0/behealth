# frozen_string_literal: true

class CreatePatientAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_addresses do |t|
      t.belongs_to :patient, null: false, foreign_key: true
      t.string :settlement, null: false
      t.string :house, null: false
      t.string :apartments

      t.timestamps
    end
  end
end
