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

def show
  @note = Note.find(params[:id])
  if @note.user != current_user && !@note.shared2all
    redirect_to days_path
  end  
  if @note.user != current_user
    @notes = @note.user.notes.where(shared2all: true).order('created_at DESC').limit(3)
   else 
    @notes = current_user.notes.order('created_at DESC').limit(3)
  end  
end

def edit
  @note = Note.find(params[:id])
  if @note.user != current_user
    redirect_to days_path
  end  
end

def update
  @note = Note.find(params[:id])
  if @note.update(note_params)
    redirect_to notes_path
  else
    render 'edit'
  end
end


def index
  @user = current_user
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
    params.require(:note).permit(:title, :text, :shared2all)
  end

end

