class SetDefaultRatingForExistingDoctors < ActiveRecord::Migration[7.0]
  def change
    Doctor.update_all(rating: 0)
  end
end
