class AttendancesController < ApplicationController
  
  before_action :authenticate_user!

  def new
    @event = Event.find_by(id: params[:event_id])
    @attendance = Attendance.new
  end

  def create
    @event = Event.find_by(id: params[:event_id])
        
    # Amount in cents
    @amount = @event.amount

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    begin
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @amount,
        description: 'Rails Stripe customer',
        currency: 'EUR',
      })
    Attendance.create(event: @event, user: User.all.sample, stripe_id: customer.id)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_attendance_path
    end

  end


end
