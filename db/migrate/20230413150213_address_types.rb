# frozen_string_literal: true

class AddressTypes < ActiveRecord::Migration[7.0]
  create_table :address_types do |t|
    t.string :name

    t.timestamps
  end
end
