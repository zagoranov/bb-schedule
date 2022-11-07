class CreateExerciseDictionaryTables < ActiveRecord::Migration
  def change

    create_table :dictcategories do |t|
      t.string :name
      t.text :description
 
      t.timestamps
    end

    create_table :dictitems do |t|
      t.string :name
      t.text :description
      t.string :url
      t.references :dictcategory

      t.timestamps
    end

  end
end