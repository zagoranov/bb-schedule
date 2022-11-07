class MealNNowString < ActiveRecord::Migration
  def change
     change_column :mealdishes, :meal_n, :string
  end
end
