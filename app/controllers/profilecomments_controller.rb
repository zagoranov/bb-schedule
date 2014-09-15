class ProfilecommentsController < ApplicationController

def new
  @comment = current_user.given_comments.new()
end


def create
    @comment = current_user.given_comments.create(comment_params)
    @comment.save
    redirect_to @comment.user
  end



def destroy
  @comment = Profilecomment.find(params[:id])
  @comment.destroy
  redirect_to @comment.user
end

  private
    def comment_params
      params.require(:profilecomment).permit(:comment, :user_id, :commenter_id)
    end

end
