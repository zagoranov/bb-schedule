class DescRuString2Text < ActiveRecord::Migration
  def change
    change_column :dictitems, :desc_ru, :text, :limit => nil
  end
end
