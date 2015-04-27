class AddTableNoteComments < ActiveRecord::Migration
  def change
    create_table :notecomments do |t|
      t.integer :user_id
      t.integer :note_id
      t.text :comment
      t.timestamps
    end
  end
end
