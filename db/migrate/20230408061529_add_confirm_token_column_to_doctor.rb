class AddConfirmTokenColumnToDoctor < ActiveRecord::Migration[7.0]
    def change
      add_column :doctors, :email_confirmed, :boolean, :default => false
      add_column :doctors, :confirm_token, :string
    end
end
