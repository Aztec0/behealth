# frozen_string_literal: true

class CreateIdCards < ActiveRecord::Migration[7.0]
  def change
    create_table :id_cards do |t|
      t.string :number
      t.string :issued
      t.date :date

      t.timestamps
    end
  end
end
