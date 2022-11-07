class AddPicsToDictItems < ActiveRecord::Migration
  def change
    add_column :dictitems, :img, :string
    add_column :dictitems, :img_ru, :string
  end
end
