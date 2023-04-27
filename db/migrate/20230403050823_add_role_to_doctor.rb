# frozen_string_literal: true

class AddRoleToDoctor < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :role, :integer, default: 0
  end
end
