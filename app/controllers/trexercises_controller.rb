class TrexercisesController < ApplicationController



def new
  @training = Training.find(params[:format])
  @trexercise = @training.trexercises.new
end


def create
    @training = Training.find(params[:training_id])
    @trexercise = @training.trexercises.create(trexercise_params)
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



  private
    def trexercise_params
      params.require(:trexercise).permit(:title, :reps, :maxweight)
    end

end
