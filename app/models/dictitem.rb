class Dictitem < ActiveRecord::Base
  has_many  :exercises
  has_many  :trexercises
end
