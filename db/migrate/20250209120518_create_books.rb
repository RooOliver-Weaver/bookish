class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.references :author, null: false, foreign_key: true
      t.text :synopsis
      t.string :cover_url
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
