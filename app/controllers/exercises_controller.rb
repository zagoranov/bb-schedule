class ExercisesController < ApplicationController

def create
    @day = Day.find(params[:day_id])
    @exercise = @day.exercises.create(exercise_params)
    redirect_to day_path(@day)
  end

def destroy
    @day = Day.find(params[:day_id])
    @exercise = @day.exercises.find(params[:id])
    @exercise.destroy
    redirect_to day_path(@day)
  end
 
  private
    def exercise_params
      params.require(:exercise).permit(:title, :reps, :maxweight)
    end
end
