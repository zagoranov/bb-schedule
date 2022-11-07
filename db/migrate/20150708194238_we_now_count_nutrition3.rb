class WeNowCountNutrition3 < ActiveRecord::Migration
  def change
     change_column :mealdishes, :dt, :date
  end
end
