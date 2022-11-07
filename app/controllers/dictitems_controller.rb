class DictitemsController < ApplicationController

def new
  @dictitem = Dictitem.new
end


def create
 @dictitem = Dictitem.create(dictitem_params)

 if @dictitem.save
    flash.now[:notice] = "Saved!"
    render 'new'
  else
    flash.now[:error] = "Error!"
    render 'new'
  end
end

def show
    redirect_to 'new'
end

def index
  @dictitems = Dictitem.order(:kind, :name)
end


private
  def dictitem_params
    params.require(:dictitem).permit(:name, :description, :url, :img, :name_ru, :desc_ru, :url_ru, :img_ru)
  end

end
