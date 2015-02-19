class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :thumbnail
      t.integer :pages_read
      t.integer :page_count
      t.integer :shelf_id

      t.timestamps null: false
    end
  end
end
