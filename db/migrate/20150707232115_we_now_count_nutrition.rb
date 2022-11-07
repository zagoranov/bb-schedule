class WeNowCountNutrition < ActiveRecord::Migration
  def change
    create_table :dictnutr do |t|
      t.string :title
      t.text :description
      t.integer  :user_id

      t.float :protein
      t.float :fat
      t.float :carbs
      t.float :calories

      t.timestamps
    end

    create_table :mealdish do |t|
      t.integer  :user_id
      t.integer  :dictnutr_id
      t.integer  :meal_n
      t.datetime :dt
      t.integer  :number
      t.float :doze

      t.timestamps
    end


  end
end
