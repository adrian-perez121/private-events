class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = Event.where(creator_id: params[:id].to_i).all.includes(:creator)
    @attended_events = @user.attended_events
  end
end
