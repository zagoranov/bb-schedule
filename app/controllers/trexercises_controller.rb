class TrexercisesController < ApplicationController



def new
  @training = Training.find(params[:format])
  @trexercise = @training.trexercises.new
end


def create
    @training = Training.find(params[:training_id])
    @trexercise = @training.trexercises.create(trexercise_params)
      trexercises = @training.trexercises.all
      numb = trexercises.select("max(number) as mx").first.mx
      if numb != nil
         @trexercise.number = numb.to_i + 1
      else
        @trexercise.number = 1
      end
      @trexercise.save
    redirect_to edit_training_path(@training)
  end


def edit
  @trexercise = Trexercise.find(params[:id])
end


def update
  @trexercise = Trexercise.find(params[:id])
  if @trexercise.update(trexercise_params)
    redirect_to edit_training_path(@trexercise.training)
  else
    render 'edit'
  end
end

def destroy
  @trexercise = Trexercise.find(params[:id])
  @training = @trexercise.training
  @trexercise.destroy
  redirect_to edit_training_path(@training)
end


def up
  trexercise = Trexercise.find(params[:id])
  numb = trexercise.number
  if numb && numb > 1
    trexer2 = Trexercise.find_by_number(numb - 1)
    trexer2.number = numb
    trexer2.save
    trexercise.number = numb - 1
    trexercise.save
  end
  redirect_to edit_training_path(trexercise.training)
end

def down
  trexercise = Trexercise.find(params[:id])
  numb = trexercise.number
  if numb
    trexer2 = Trexercise.find_by_number(numb + 1)
    if trexer2
      trexer2.number = numb
      trexer2.save
      trexercise.number = numb + 1
      trexercise.save
    end
  end
  redirect_to edit_training_path(trexercise.training)
end



  private
    def trexercise_params
      params.require(:trexercise).permit(:title, :reps, :maxweight)
    end

end
