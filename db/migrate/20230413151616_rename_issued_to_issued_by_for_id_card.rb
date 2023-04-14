class RenameIssuedToIssuedByForIdCard < ActiveRecord::Migration[7.0]
  def change
    rename_column :id_cards, :issued, :issued_by
  end
end
