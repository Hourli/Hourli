class NotificationsController < ApplicationController
  def index
    @unread_notifications = current_user.notifications.where(read: false).order(created_at: :desc)
    @read_notifications = current_user.notifications.where(read: true).order(created_at: :desc)
    respond_to do |format|
      format.html {}
      format.json { render json: @unread_notifications.count}
      format.js {
        limit = 5
       if @unread_notifications.count > limit
         @unread_notifications = @unread_notifications.slice(0, limit)
       end
      }
    end
  end

  def toggle_read_status
    respond_to do |format|
      format.js {
        status = :ok
        @notification = Notification.find_by_id(params[:id])
        if @notification.nil?
          status = :bad_request
        elsif @notification.user.id != current_user.id
          status = :bad_request
        else
          @notification.read = (@notification.read) ? false : true
          @notification.save
        end
        render :toggle_read_status, status: status
      }
    end
  end
end
