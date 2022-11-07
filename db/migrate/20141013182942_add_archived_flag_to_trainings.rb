class AddArchivedFlagToTrainings < ActiveRecord::Migration
  def change
    add_column :trainings, :archived, :boolean, :default => false
  end
end
