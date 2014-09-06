class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.float :weight
      t.text :info

      t.references :day, index: true 
      
      t.timestamps
    end
  end
end
