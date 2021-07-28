class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :title
      t.text :body
      t.string :category
      t.references :user,foreign_key:true

      t.timestamps
    end
  end
end
