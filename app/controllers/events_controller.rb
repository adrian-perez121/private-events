class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :require_user, only: [:new, :create]

  def index
    @events = Event.all.includes(:creator)
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

  def require_user
    if current_user.id == params[:user_id].to_i
    else
      flash.notice = "You cannot create an event for someone else"
      redirect_to root_path
    end
  end
end
