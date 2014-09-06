class Day < ActiveRecord::Base
  belongs_to :user
  has_many :exercises
  has_many :trainings

  validates :title, presence: true
end
