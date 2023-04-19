class AddToDoctorsEmailConfirm < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :email_confirmed, :boolean, :default => true
  end
end
