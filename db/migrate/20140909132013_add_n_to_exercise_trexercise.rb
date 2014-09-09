class AddNToExerciseTrexercise < ActiveRecord::Migration
  def change
    add_column :exercises, :number, :integer
    add_column :trexercises, :number, :integer
  end
end
