class AddItnToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :ITN, :string
  end
end
