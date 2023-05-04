class ChangeRatingTypeForHospital < ActiveRecord::Migration[7.0]
  def change
    change_column :hospitals, :rating, :float
  end
end
