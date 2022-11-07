class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|

      t.float :height
      t.float :weight

      t.float :neck
      t.float :shoulders
      t.float :chest

      t.float :biceps
      t.float :forearm
      t.float :wrist 

      t.float :waist

      t.float :thighs
      t.float :calves

      t.timestamps
    end
  end
end

