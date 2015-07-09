class Dictnutr < ActiveRecord::Base
  belongs_to :user
  has_many   :mealdishes
end

