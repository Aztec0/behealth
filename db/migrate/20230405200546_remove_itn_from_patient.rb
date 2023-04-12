class RemoveItnFromPatient < ActiveRecord::Migration[7.0]
  def change
    remove_column :patients, :ITN, :integer
  end
end
