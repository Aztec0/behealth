# frozen_string_literal: true

class AddPasswordResetColumnsToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :reset_password_token, :string
    add_column :patients, :token_sent_at, :datetime
  end
end
