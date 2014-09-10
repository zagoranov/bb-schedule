class ExercisesController < ApplicationController

def create
    @day = Day.find(params[:day_id])
    @exercise = @day.exercises.create(exercise_params)
    exercises = @day.exercises.all
    numb = exercises.maximum("number")  
    if numb != nil
      @exercise.number = numb.to_i + 1
    else
      @exercise.number = 1
    end
    @exercise.save
    redirect_to day_path(@day)
  end

def destroy
    @day = Day.find(params[:day_id])
    @exercise = @day.exercises.find(params[:id])
    numb = @exercise.number
    if numb
      exercises = @day.exercises.where('number > ?', numb)
      exercises.each do |exer|
        exer.number = exer.number - 1
        exer.save
      end
    end
    @exercise.destroy
    redirect_to day_path(@day)
  end
 
def up
  exercise = Exercise.find(params[:id])
  numb = exercise.number
  if numb > 1
    day = exercise.day
    exer2 = day.exercises.find_by_number(numb - 1)
    if exer2
      exer2.number = numb
      exer2.save
      exercise.number = numb - 1
      exercise.save
    end
  end
  redirect_to exercise.day
end

def down
  exercise = Exercise.find(params[:id])
  numb = exercise.number
  day = exercise.day
  exer2 = day.exercises.find_by_number(numb + 1)
  if exer2
    exer2.number = numb
    exer2.save
    exercise.number = numb + 1
    exercise.save
  end
  redirect_to exercise.day
end


  private
    def exercise_params
      params.require(:exercise).permit(:title, :reps, :maxweight)
    end
end
