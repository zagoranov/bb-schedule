class DropThatTables < ActiveRecord::Migration
  def change
  def up
    drop_table :trainings
    drop_table :maxweights
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
  end
end
