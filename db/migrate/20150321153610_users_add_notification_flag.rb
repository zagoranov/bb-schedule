class UsersAddNotificationFlag < ActiveRecord::Migration
  def change
    add_column :users, :notific, :boolean, :default => true
  end
end
