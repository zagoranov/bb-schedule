class Notecomment < ActiveRecord::Base
  belongs_to :note # comment about blog post
  belongs_to :user 
end
