class MeasurementsController < ApplicationController

respond_to :html, :js

def new
  @meas = Measurement.new
end


def create
  meas = current_user.measurements.create(meas_params)
  meas.save
  redirect_to measurements_path
end

def edit
  @meas = Measurement.find(params[:id])
end


def update
  meas = Measurement.find(params[:id])
  if meas.update(meas_params)
    redirect_to measurements_path
  else
    render 'edit'
  end
end


def index
  @meases = current_user.measurements.order('created_at DESC')
end


def destroy
  meas = Measurement.find(params[:id])
  meas.destroy
  @meases = current_user.measurements.order('created_at DESC')
  respond_to do |format|
    format.js { render partial: 'meas_refresh'  }
  end
end



private
  def meas_params
    params.require(:measurement).permit(:weight, :neck, :shoulders, :chest, :biceps, :forearm, :wrist, :waist, :thighs, :calves)
  end


end
