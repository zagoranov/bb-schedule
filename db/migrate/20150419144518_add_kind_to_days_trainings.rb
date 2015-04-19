class AddKindToDaysTrainings < ActiveRecord::Migration
  def change
    add_column :days, :kind, :integer, :default => 0
    add_column :trainings, :kind, :integer, :default => 0
    add_column :dictitems, :kind, :integer, :default => 0
  end
end
