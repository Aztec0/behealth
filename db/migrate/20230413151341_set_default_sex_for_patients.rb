# frozen_string_literal: true

class SetDefaultSexForPatients < ActiveRecord::Migration[7.0]
  def change
    change_column_default :patients, :sex, 0
  end
end
