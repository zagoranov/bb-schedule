class DictnutrsController < ApplicationController

def new
  @dictnutr = Dictnutr.new
end


def create
 @dictnutr = Dictnutr.create(dictnutr_params)
 @dictnutr.user = current_user

 if @dictnutr.save
    flash.now[:notice] = "Saved!"
    redirect_to session.delete(:return_to)
  else
    flash.now[:error] = "Error!"
    render 'new'
  end
end

def index
  @dictnutrs = Dictnutr.order(:title)
end


private
  def dictnutr_params
    params.require(:dictnutr).permit(:title, :description, :protein, :fat, :carbs, :calories)
  end


end
