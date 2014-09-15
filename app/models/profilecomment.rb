class Profilecomment < ActiveRecord::Base
  belongs_to :user # comment about profile
  belongs_to :commenter, :class_name => "User", :foreign_key => "commenter_id"
end
