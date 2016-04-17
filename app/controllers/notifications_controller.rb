class NotificationsController < ApplicationController
  def index
    @unread_notifications = current_user.notifications.where(read: false, hidden: false).order(created_at: :desc)
    @read_notifications = current_user.notifications.where(read: true, hidden: false).order(created_at: :desc)
    respond_to do |format|
      format.html {}
      format.json {
        if @unread_notifications.count > 0
          session[:unread_notification_count] = @unread_notifications.count
        else
          session[:unread_notification_count] = ''
        end
        render json: @unread_notifications.count
      }
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

  def hide
    status = :found
    notification = Notification.find_by(id: params[:id])
    if notification.nil? or notification.user.id != current_user.id
      status = :bad_request
    else
      notification.hidden = ! notification.hidden
      notification.save
    end
    redirect_to notifications_path, status: status
  end

end
