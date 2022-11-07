class AddShareFlagsToDays < ActiveRecord::Migration
  def change
    add_column :days, :shared2all, :boolean, :default => false
  end
end
