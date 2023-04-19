class AddSecondNameAndDescriptionToDoctor < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :second_name, :string
    add_column :doctors, :description, :text
    add_column :doctors, :price, :decimal
  end
end
