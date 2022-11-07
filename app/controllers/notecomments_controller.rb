class NotecommentsController < ApplicationController

respond_to :html, :js

def new
  note = Note.find(params['note_id'])
  @comment = note.notecomments.new()
end


def create
    @note = Note.find(params['note_id'])
    @comment = @note.notecomments.create(notecomment_params)
    @comment.save
    respond_to do |format|
      format.js { render partial: '/notes/wall_refresh'  }
    end
end



def destroy
  @comment = Notecomment.find(params[:id])
  @note = @comment.note
  @comment.destroy
  respond_to do |format|
      format.js { render partial: '/notes/wall_refresh'  }
  end
end

  private
    def notecomment_params
      params.require(:notecomment).permit(:comment, :user_id, :note_id)
    end

end
