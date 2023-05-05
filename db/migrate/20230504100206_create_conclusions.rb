class CreateConclusions < ActiveRecord::Migration[7.0]
  def change
    create_table :conclusions do |t|
      t.string :text
      t.references :doctor, foreign_key: true
      t.references :appointment, foreign_key: true
      t.timestamps
    end
  end
end
