# frozen_string_literal: true

class CreatePatientDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_documents do |t|
      t.belongs_to :patient, null: false
      t.references :document, polymorphic: true

      t.timestamps
    end
  end
end
