class HeckDaCategories < ActiveRecord::Migration
  def change
	remove_column :dictitems, :dictcategory_id
        drop_table :dictcategories
  end


  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
