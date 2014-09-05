class ChangeWeightNAme < ActiveRecord::Migration
  def change
    remove_column :exercises, :weight
    add_column :exercises, :maxweight, :integer
  end
end
