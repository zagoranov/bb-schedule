class AddUserIdToDayandTrenning < ActiveRecord::Migration
  def change
   change_table :days do |t|
      t.references :user, index: true 
     end
   change_table :trainings do |t|
      t.references :user, index: true 
     end
  end
end
