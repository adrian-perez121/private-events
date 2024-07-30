class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @events = current_user.invited_events
      @past_events = @events.where('date < ?', Date.today)
      @now_and_future = @events.where('date >= ?', Date.today)
    else
      @past_events = []
      @now_and_future = []
    end
    # @past_events = Event.past.includes(:creator).order(date: :desc)
    # @now_and_future = Event.now_and_future.includes(:creator).order(date: :desc)
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
    @invited_users = @event.invited_users
    @not_invited_users = User.not_invited_to_event(params[:id])
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

  def edit
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to @user
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date)
  end
end
