class CreateProfilecomments < ActiveRecord::Migration
  def change
    create_table :profilecomments do |t|
      t.integer :user_id
      t.integer :commenter_id
      t.text :comment

      t.timestamps
    end
  end
end
