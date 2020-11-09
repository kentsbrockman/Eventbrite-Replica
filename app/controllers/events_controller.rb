class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :is_admin?, only: [:edit, :update, :destroy]
  
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user
    if @event.save
      flash[:success] = "Your event has been created!"
      redirect_to event_path(@event.id)
    else
      flash.now[:alert] = "We cannot create the event for the following reason(s):"
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:success] = "Your event has been updated!"
      redirect_to event_path(@event.id), success: "Your event has been successfully updated!"
    else
      flash.now[:alert] = "We cannot update the event for the following reason(s):"
      render :edit
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to user_path(current_user.id)
  end

  private
  def event_params
    event_params = params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :event_picture)
    event_params[:start_date] = str_to_datetime(event_params[:start_date])
    event_params[:duration] = event_params[:duration].to_i 
    event_params[:price] = event_params[:price].to_i 
    return event_params
  end

  def str_to_datetime(str)
    DateTime.parse(str+'+01:00')
  end

  def is_admin?
    @event = Event.find(params[:id])
    unless @event.admin == current_user
      redirect_to event_path,
      warning: "Sorry bro! You can't just edit an event that's not yours to begin with 😁"
    end
  end

end
