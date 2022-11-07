class Mealdish < ActiveRecord::Base
  belongs_to :dictnutr
  belongs_to :user
end
