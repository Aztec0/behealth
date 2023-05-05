class AddDoctorableToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :doctorable_id, :bigint
    add_column :feedbacks, :doctorable_type, :string

    add_index :feedbacks, [:doctorable_type, :doctorable_id]

    remove_foreign_key :feedbacks, :doctors
    remove_reference :feedbacks, :doctor, index: true
  end
end
