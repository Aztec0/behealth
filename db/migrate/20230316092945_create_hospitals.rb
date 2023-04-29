# frozen_string_literal: true

class CreateHospitals < ActiveRecord::Migration[7.0]
  def change
    create_table :hospitals do |t|
      t.string :region
      t.string :city
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
