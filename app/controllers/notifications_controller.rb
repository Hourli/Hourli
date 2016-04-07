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
        ids = params[:id].split(',')
        @notifications, status = fetch_and_update_notifications(ids)
        render :toggle_read_status, status: status
      }
    end
  end


  def fetch_and_update_notifications(ids)
    status = :ok
    results = nil
    begin
      results = Notification.find(ids)
      status = :bad_request if results.nil? or results.empty?
      results.each do |notification|
        if notification.user.id != current_user.id
          results = nil
          status = :bad_request
          break
        else
          notification.read = (notification.read) ? false : true
          notification.save
        end
      end
    rescue ActiveRecord::RecordNotFound
      results = nil
      status = :bad_request
    end
    return results, status
  end

end
