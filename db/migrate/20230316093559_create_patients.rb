# frozen_string_literal: true

class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :surname
      t.date :birthday
      t.string :email
      t.bigint :phone
      t.string :password_digest

      t.timestamps
    end
  end
end
