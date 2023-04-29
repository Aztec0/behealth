class RenameItnToTin < ActiveRecord::Migration[7.0]
  def change
    rename_column :patients, :itn, :tin
  end
end
