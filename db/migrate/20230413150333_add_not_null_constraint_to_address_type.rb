# frozen_string_literal: true

class AddNotNullConstraintToAddressType < ActiveRecord::Migration[7.0]
  def change
    change_column :patient_addresses, :address_type, :string, null: false
  end
end
