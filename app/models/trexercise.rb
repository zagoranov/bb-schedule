class Trexercise < ActiveRecord::Base
  belongs_to :training
  belongs_to :dictitem
end
