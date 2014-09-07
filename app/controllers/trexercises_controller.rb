class TrexercisesController < ApplicationController


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

  private
    def trexercise_params
      params.require(:trexercise).permit(:title, :reps, :maxweight)
    end

end
