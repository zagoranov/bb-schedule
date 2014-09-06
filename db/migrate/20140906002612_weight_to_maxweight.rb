class WeightToMaxweight < ActiveRecord::Migration
  def change
    remove_column :trexercises, :weight
    add_column :trexercises, :maxweight, :float

    remove_column :exercises, :maxweight
    add_column :exercises, :maxweight, :float
  end
end
