class ProfilecommentsController < ApplicationController

respond_to :html, :js

def new
  @comment = current_user.given_comments.new()
end


def create
    @comment = current_user.given_comments.create(comment_params)
    @comment.save
    @user = User.find(params['user_id'])
    respond_to do |format|
      format.js { render partial: '/users/wall_refresh'  }
    end
end



def destroy
  @comment = Profilecomment.find(params[:id])
  @user = current_user
  @comment.destroy
  respond_to do |format|
    format.js { render partial: '/users/wall_refresh'  }
  end
end

  private
    def comment_params
      params.require(:profilecomment).permit(:comment, :user_id, :commenter_id)
    end

end
