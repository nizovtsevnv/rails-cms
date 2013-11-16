class CreateContentUploads < ActiveRecord::Migration
  def change
    create_table :content_uploads do |t|
      t.attachment :attachment
      t.string :name
      t.timestamps
    end

    add_index :content_uploads, :name
  end
end
