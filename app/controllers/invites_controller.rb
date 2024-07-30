class InvitesController < ApplicationController
  before_action :authenticate_user!


  def create
    @event = Event.find(params[:event_id])

    if @event.creator == current_user
      Invite.create!(invited_id: params[:user_id], event_id: params[:event_id])
      redirect_to @event
    else
      flash.notice = "This is not your event"
      redirect_to root_path
    end
  end
end
