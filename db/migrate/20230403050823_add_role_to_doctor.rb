class AddRoleToDoctor < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :role, :integer, default: 1
  end
end
