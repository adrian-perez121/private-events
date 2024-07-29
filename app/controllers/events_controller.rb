class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :require_user, only: [:new, :create]

  def index
    @past_events = Event.past.includes(:creator).order(date: :desc)
    @now_and_future = Event.now_and_future.includes(:creator).order(date: :desc)
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
  end

  def new
    @user = User.find(params[:user_id])
    @event = @user.created_events.build
  end

  def create
    @user = User.find(params[:user_id])
    @event = @user.created_events.build(event_params)

    if @event.save
      EventsDetail.create(attendee_id: @user.id, event_id: @event.id)
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date)
  end

  def require_user
    if current_user.id == params[:user_id].to_i
    else
      flash.notice = "You cannot create an event for someone else"
      redirect_to root_path
    end
  end
end
