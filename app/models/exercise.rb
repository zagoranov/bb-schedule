class Exercise < ActiveRecord::Base
  belongs_to :day

  validates :title, presence: true
end
