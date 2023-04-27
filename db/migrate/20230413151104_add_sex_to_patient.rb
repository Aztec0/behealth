# frozen_string_literal: true

class AddSexToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :sex, :integer
  end
end
