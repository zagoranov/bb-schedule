class UserDayIndex < ActiveRecord::Migration
  def change
	remove_column :days, :user_id

   change_table :days do |t|
      t.references :user, index: true 
     end

  end
end
