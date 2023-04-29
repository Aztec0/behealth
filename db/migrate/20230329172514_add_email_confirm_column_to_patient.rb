# frozen_string_literal: true

class AddEmailConfirmColumnToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :email_confirmed, :boolean, default: false
    add_column :patients, :confirm_token, :string
  end
end
