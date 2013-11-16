class CreateContentWidgets < ActiveRecord::Migration
  def change
    create_table :content_widgets do |t|
      t.references :page
      t.string :locale_name
      t.string :name
      t.text :body
      t.timestamps
    end

    add_index :content_widgets, :locale_name
    add_index :content_widgets, :name
    add_index :content_widgets, :page_id
  end
end
