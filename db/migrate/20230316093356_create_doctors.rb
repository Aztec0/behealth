# frozen_string_literal: true

class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :surname
      t.date :birthday
      t.string :position
      t.belongs_to :hospital, null: true, foreign_key: true
      t.string :email
      t.bigint :phone
      t.string :password_digest

      t.timestamps
    end
  end
end
