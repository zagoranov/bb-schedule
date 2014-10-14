class NotesController < ApplicationController

respond_to :html, :js

def create
  note = current_user.notes.create(note_params)
  note.save
  @notes = current_user.notes.order('created_at DESC')
  respond_to do |format|
    format.js { render partial: 'notes_refresh'  }
  end
end



def index
  @notes = current_user.notes.order('created_at DESC')
end


def destroy
  note = Note.find(params[:id])
  note.destroy
  @notes = current_user.notes.order('created_at DESC')
  respond_to do |format|
    format.js { render partial: 'notes_refresh'  }
  end
end



private
def note_params
    params.require(:note).permit(:title, :text)
  end

end

