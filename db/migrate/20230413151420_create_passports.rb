# frozen_string_literal: true

class CreatePassports < ActiveRecord::Migration[7.0]
  def change
    create_table :passports do |t|
      t.string :series
      t.string :number
      t.string :issued_by
      t.date :date

      t.timestamps
    end
  end
end
