class ExercisesController < ApplicationController

respond_to :html, :js

def create
    @day = Day.find(params[:day_id])
    @exercise = @day.exercises.create(exercise_params)

    if @exercise.dictitem
        if I18n.locale == :en
          @exercise.title = @exercise.dictitem.name
      else
          @exercise.title = @exercise.dictitem.name_ru
      end
    end
    exercises = @day.exercises.all
    numb = exercises.maximum("number")  
    if numb != nil
      @exercise.number = numb.to_i + 1
    else
      @exercise.number = 1
    end
    @exercise.save
    redirect_to day_path(@day), :notice => t(:exer_added)
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
      respond_to do |format|
        format.js { render partial: 'ex_list_refresh'  }
      end
    #redirect_to day_path(@day), :notice => t(:exer_deleted)
  end

 
def up
  exercise = Exercise.find(params[:id])
  numb = exercise.number
  if numb > 1
    @day = exercise.day
    exer2 = @day.exercises.find_by_number(numb - 1)
    if exer2
      exer2.number = numb
      exer2.save
      exercise.number = numb - 1
      exercise.save
      respond_to do |format|
        format.js { render partial: 'ex_list_refresh'  }
      end
    end
  end
end


def down
  exercise = Exercise.find(params[:id])
  numb = exercise.number
  @day = exercise.day
  exer2 = @day.exercises.find_by_number(numb + 1)
  if exer2
    exer2.number = numb
    exer2.save
    exercise.number = numb + 1
    exercise.save
    respond_to do |format|
      format.js { render partial: 'ex_list_refresh'  }
    end
  end
end


  private
    def exercise_params
      params.require(:exercise).permit(:title, :reps, :maxweight, :dictitem_id)
    end
end
