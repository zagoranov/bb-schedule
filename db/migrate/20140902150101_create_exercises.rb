class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :title
      t.string :reps
      t.references :day, index: true

      t.timestamps
    end
  end
end
