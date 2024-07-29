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
    end

  end
end
