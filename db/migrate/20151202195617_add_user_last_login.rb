class AddUserLastLogin < ActiveRecord::Migration
  def change
    add_column :users, :lastlogin, :datetime
  end
end
