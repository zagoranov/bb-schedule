class AddNumberToDays < ActiveRecord::Migration
  def change
    add_column :days, :number, :integer
  end
end
