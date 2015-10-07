class CreatePostattachments < ActiveRecord::Migration
  def change
    create_table :postattachments do |t|
      t.string :picture
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
