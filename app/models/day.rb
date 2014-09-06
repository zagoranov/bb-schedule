class Day < ActiveRecord::Base
  belongs_to :user
  has_many  :exercises, dependent: :destroy
  has_many  :trainings, dependent: :destroy

  validates :title, presence: true
end
