class AddDeletedFlagToDays < ActiveRecord::Migration
  def change
    add_column :days, :erased, :boolean, :default => false
  end
end
