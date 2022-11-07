class AddOpenFlagToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :shared2all, :boolean, :default => false
  end
end
