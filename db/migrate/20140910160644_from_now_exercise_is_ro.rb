class FromNowExerciseIsRo < ActiveRecord::Migration
  def change
    add_column :dictcategories, :name_ru, :string
    add_column :dictcategories, :desc_ru, :string
    add_column :dictitems, :name_ru, :string
    add_column :dictitems, :desc_ru, :string
    add_column :dictitems, :url_ru, :string

    add_reference :exercises, :dictitem
    add_reference :trexercises, :dictitem
  end
end
