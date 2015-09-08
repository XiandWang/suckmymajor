class NotificationsController < ApplicationController
  before_action :logged_in_user
  def index
  	@notifications = current_user.notifications.unread
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy
    redirect_to notifications_path 
  end
end
