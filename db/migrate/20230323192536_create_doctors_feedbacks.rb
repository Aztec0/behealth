class CreateDoctorsFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors_feedbacks do |t|
      t.belongs_to :doctor, null: false, foreign_key: true
      t.belongs_to :patient, null: false, foreign_key: true
      t.integer :rating
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
