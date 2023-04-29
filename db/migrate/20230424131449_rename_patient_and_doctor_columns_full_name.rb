# frozen_string_literal: true

class RenamePatientAndDoctorColumnsFullName < ActiveRecord::Migration[7.0]
  def change
    rename_column :patients, :name, :first_name
    rename_column :patients, :surname, :last_name
    rename_column :patients, :fathername, :second_name
    rename_column :doctors, :name, :first_name
    rename_column :doctors, :surname, :last_name
    rename_column :doctors, :description, :about
    rename_column :doctors, :price, :admission_price
  end
end
