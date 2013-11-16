class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
      t.string :name
      t.string :title
      t.timestamps
    end

    add_index :locales, :name
  end
end
