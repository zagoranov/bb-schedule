class CreateTrexercises < ActiveRecord::Migration
  def change
    create_table :trexercises do |t|
      t.string :title
      t.string :reps
      t.integer :weight

      t.references :training, index: true 



      t.timestamps
    end
  end
end
