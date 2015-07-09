class WeNowCountNutrition2 < ActiveRecord::Migration
  def change
   rename_table :mealdish, :mealdishes
   rename_table :dictnutr, :dictnutrs
  end
end
