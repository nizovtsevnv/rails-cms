class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user
      t.string :action
      t.string :agent
      t.string :controller
      t.string :identifier
      t.string :ip
      t.string :host
      t.text :data
      t.timestamps
    end

    add_index :activities, :action
    add_index :activities, :controller
    add_index :activities, :ip
    add_index :activities, :host
    add_index :activities, :user_id
  end
end
