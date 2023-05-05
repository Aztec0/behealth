class SetDefaultRatingForExistingHospitals < ActiveRecord::Migration[7.0]
  def change
    Hospital.update_all(rating: 0)
  end
end
