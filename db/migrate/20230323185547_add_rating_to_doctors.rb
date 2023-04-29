# frozen_string_literal: true

class AddRatingToDoctors < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :rating, :integer
    change_column_default :doctors, :rating, 0
  end
end
