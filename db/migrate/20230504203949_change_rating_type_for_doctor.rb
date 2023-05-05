class ChangeRatingTypeForDoctor < ActiveRecord::Migration[7.0]
  def change
    change_column :doctors, :rating, :float
  end
end
