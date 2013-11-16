class CreateContentPages < ActiveRecord::Migration
  def change
    create_table :content_pages do |t|
      t.string :locale_name
      t.string :name
      t.string :state
      t.text :body
      t.text :description
      t.text :keywords
      t.text :title
      t.timestamps
    end

    add_index :content_pages, :locale_name
    add_index :content_pages, :name
    add_index :content_pages, :state
  end
end
