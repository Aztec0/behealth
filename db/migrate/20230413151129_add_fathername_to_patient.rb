# frozen_string_literal: true

class AddFathernameToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :fathername, :string
  end
end
