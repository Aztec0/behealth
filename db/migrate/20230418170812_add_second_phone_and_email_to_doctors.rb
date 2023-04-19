class AddSecondPhoneAndEmailToDoctors < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :second_email, :string
    add_column :doctors, :second_phone, :bigint
  end
end
