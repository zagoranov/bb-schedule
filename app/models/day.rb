class Day < ActiveRecord::Base
  has_many  :exercises, dependent: :destroy
  validates :title, presence: true
end
