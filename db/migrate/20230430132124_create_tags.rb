class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.references :tagable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
