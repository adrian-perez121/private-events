class EventsDetailsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @event = Event.find(params[:event_id])

    if EventsDetail.where(attendee_id: @user.id, event_id: @event.id).exists?
      flash.notice = "You are already attending this event!"
      redirect_to root_path
    else
      EventsDetail.create!(attendee_id: @user.id, event_id: @event.id)
      redirect_to @event
    end

  end

  def destroy
    @event = Event.find(params[:event_id])
    @event_detail = EventsDetail.find_by!(attendee_id: params[:user_id], event_id: params[:event_id])

    @event_detail.destroy
    redirect_to @event
  end
end
