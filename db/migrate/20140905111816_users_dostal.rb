class UsersDostal < ActiveRecord::Migration
  def change
    remove_column :users, :password_hash, :string
    remove_column :users, :password_salt, :string
    add_column :users, :encrypted_password, :string
    add_column :users, :salt, :string
  end
end
