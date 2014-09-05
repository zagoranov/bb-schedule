class RemoveColumnFromModel < ActiveRecord::Migration
  def change
    remove_column :trainings, :weight
    add_column :trainings, :weight, :integer
  end
end
