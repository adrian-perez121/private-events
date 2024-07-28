class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all
  end

  def new
    @user = User.find(params[:user_id])
    @event = @user.created_events.build
  end

  def create
    @user = User.find(params[:user_id])
    @event = @user.created_events.build(event_params)

    if @event.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date)
  end

end
