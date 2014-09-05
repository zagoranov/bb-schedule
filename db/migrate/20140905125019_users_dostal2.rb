class UsersDostal2 < ActiveRecord::Migration
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :salt
    remove_column :users, :password_digest
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string



  end
end
