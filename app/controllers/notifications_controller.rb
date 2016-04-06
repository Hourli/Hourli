class NotificationsController < ApplicationController
  def index
    @unread_notifications = current_user.notifications.where(read: false)
    @read_notifications = current_user.notifications.where(read: true)
    respond_to do |format|
      format.html {}
      format.json { render json: @unread_notifications.count}
    end
  end

  def toggle_read_status
    respond_to do |format|
      format.js {
        status = :ok
        msg = 'successfully updated'
        @notification = Notification.find_by_id(params[:id])
        if @notification.nil?
          status = :bad_request
          msg = 'Invalid notification id'
        elsif @notification.user.id != current_user.id
          status = :bad_request
          msg = 'You do not have permission to do this'
        else
          @notification.read = (@notification.read) ? false : true
          @notification.save
        end
        render :toggle_read_status, status: status, text: msg
      }
    end
  end
end
