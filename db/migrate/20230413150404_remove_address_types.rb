# frozen_string_literal: true

class RemoveAddressTypes < ActiveRecord::Migration[7.0]
  def change
    drop_table :address_types
  end
end
