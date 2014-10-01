class AddArchivedFlagToDays < ActiveRecord::Migration
  def change
    add_column :days, :archived, :boolean, :default => false
  end
end
