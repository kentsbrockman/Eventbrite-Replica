class AttendancesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :is_admin?, only: [:index]

  def index
    @event = Event.find_by(id: params[:event_id])
    @attendances = @event.attendances
  end
  
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
    Attendance.create(event: @event, user: current_user, stripe_id: customer.id)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_attendance_path
    end

  end

  
private

def is_admin?
  redirect_to root_path, danger: "WTF" unless @event.is_admin?(current_user)
end

end
