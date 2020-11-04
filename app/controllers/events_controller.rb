class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
  end

  def show
  end

  def terms
  end

  def privacy
  end

  def contact
  end

  def team
  end

end
