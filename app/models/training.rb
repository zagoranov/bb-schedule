class Training < ActiveRecord::Base
  belongs_to :day
  has_many  :trexercises
end
