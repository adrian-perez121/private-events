class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = Event.where(creator_id: params[:id].to_i).all.includes(:creator)
  end
end
