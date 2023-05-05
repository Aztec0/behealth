class AddRatingToHospital < ActiveRecord::Migration[7.0]
  def change
    add_column :hospitals, :rating, :integer
    change_column_default :hospitals, :rating, 0
  end
end
