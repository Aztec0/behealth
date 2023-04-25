# frozen_string_literal: true

class RemoveReferencessHospitalToDoctor < ActiveRecord::Migration[7.0]
  def change
    remove_reference :hospitals, :doctor
  end
end
