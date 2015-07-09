class TrexercisesController < ApplicationController

def new
  @training = Training.find(params[:format])
  @trexercise = @training.trexercises.new
end


def create
    @training = Training.find(params[:training_id])
    @trexercise = @training.trexercises.create(trexercise_params)

    if @trexercise.dictitem
        if I18n.locale == :en
          @trexercise.title = @trexercise.dictitem.name
      else
          @trexercise.title = @trexercise.dictitem.name_ru
      end
    end

      trexercises = @training.trexercises.all
      numb = trexercises.maximum("number")  
      if numb != nil
         @trexercise.number = numb.to_i + 1
      else
        @trexercise.number = 1
      end
      @trexercise.save
    redirect_to edit_training_path(@training), :notice => t(:exer_added)
  end


def edit
  @trexercise = Trexercise.find(params[:id])
end


def update
  @trexercise = Trexercise.find(params[:id])
  if @trexercise.update(trexercise_params)
    day = @trexercise.training.day
    exer = day.exercises.find_by_title(@trexercise.title)  
    if exer
      exer.reps = @trexercise.reps
      exer.maxweight = @trexercise.maxweight
      exer.save
    end
    redirect_to edit_training_path(@trexercise.training)
  else
    render 'edit'
  end
end

def destroy
  @trexercise = Trexercise.find(params[:id])
  @training = @trexercise.training
    numb = @trexercise.number
    trexercises = @training.trexercises.where('number > ?', numb)
    trexercises.each do |trexer|
      trexer.number = trexer.number - 1
      trexer.save
    end
  @trexercise.destroy
  respond_to do |format|
    format.js { render partial: 'trlistrefresh'  }
  end
end


def up
  trexercise = Trexercise.find(params[:id])
  numb = trexercise.number
  if numb > 1
    @training = trexercise.training
    trexer2 = @training.trexercises.find_by_number(numb - 1)
    if trexer2
      trexer2.number = numb
      trexer2.save
      trexercise.number = numb - 1
      trexercise.save
      respond_to do |format|
         format.js { render partial: 'trlistrefresh'  }
      end
    end
  end
end

def down
  trexercise = Trexercise.find(params[:id])
  numb = trexercise.number
  @training = trexercise.training
  trexer2 = @training.trexercises.find_by_number(numb + 1)
    if trexer2
      trexer2.number = numb
      trexer2.save
      trexercise.number = numb + 1
      trexercise.save
      respond_to do |format|
         format.js { render partial: 'trlistrefresh'  }
      end
    end
end



  private
    def trexercise_params
      params.require(:trexercise).permit(:title, :reps, :maxweight, :dictitem_id)
    end

end

