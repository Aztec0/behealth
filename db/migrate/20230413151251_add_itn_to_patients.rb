class AddItnToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :itn, :integer
  end
end