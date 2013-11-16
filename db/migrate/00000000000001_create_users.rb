class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :state
      t.string :token
      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :state
  end
end
