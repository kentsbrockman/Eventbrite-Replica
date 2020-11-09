class AttendancesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :is_admin?, only: [:index]
  before_action :can_register?

  def index
    @event = Event.find_by(id: params[:event_id])
    @attendances = @event.attendances
  end
  
  def new
    @event = Event.find_by(id: params[:event_id])
    @amount = @event.amount

    if @amount == 0
      Attendance.create(event: @event, user: current_user, stripe_id: "Free")
      redirect_to event_path(@event),
      success: "You're now registered for this event!"
    end

    if @event.admin == current_user
      redirect_to event_path(@event),
      info: "You're the administrator of this event, no need to register ^^"
    end
  end

  def create
    @event = Event.find_by(id: params[:event_id])
        
    # Amount in cents originally
    @amount = @event.amount

    customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
    
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'EUR',
    })

    Attendance.create(event: @event, user: current_user, stripe_id: customer)
    redirect_to event_path(@event),
    success: "You're now registered for this event!"

    rescue Stripe::CardError => e
      flash[:warning] = e.message
      redirect_to new_attendance_path
  end

  private

  def is_admin?
    @event = Event.find_by(id: params[:event_id])
    unless @event.admin == current_user
      redirect_to event_path(@event),
      warning: "Sorry pal, you can't see the attendees of this event if you don't have administrative rights on it."
    end
  end

  def can_register?
    @event = Event.find_by(id: params[:event_id])
    if @event.users.select{ |user| user == current_user }.count == 0
      return true
    else
      redirect_to event_path(@event),
      info: "You're already registered bro!"
    end
  end

end

