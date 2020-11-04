class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]
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
      flash[:notice] = "Event create"
      redirect_to event_path(@event.id)
    else
      flash.now[:alert] = "We cannot create this event for this reason(s) :"
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @events = Event.where(admin: @event.admin)
  end

  private
  def event_params
    event_params = params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
    event_params[:start_date] = str_to_datetime(event_params[:start_date])
    event_params[:duration] = event_params[:duration].to_i 
    event_params[:price] = event_params[:price].to_i 
    return event_params
  end

  def str_to_datetime(str)
    DateTime.parse(str+'+01:00')
  end


end
