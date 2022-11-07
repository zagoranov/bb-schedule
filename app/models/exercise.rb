class Exercise < ActiveRecord::Base
  belongs_to :day
  belongs_to :dictitem

#  validates :title, presence: true
end
