# frozen_string_literal: true

class AddAddressTypeToPatientAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_addresses, :address_type, :bigint
  end
end
