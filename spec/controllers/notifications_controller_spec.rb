require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create(:user, role: 'both')
      @user.confirmed_at = Time.now
      @user.save!
      sign_in :user, @user
    end

    it "should return http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should render the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    context "notifications exist" do
      it "should assign @unread_notifications, sorted by descending created at" do
        # Note these need to be in order of creation descending
        unread_notification_1 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notification_2 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notifications = [unread_notification_2, unread_notification_1]
        get :index
        expect(assigns[:unread_notifications]).to eq(unread_notifications)
      end

      it "should assign @read_notifications" do
        # Note these need to be in order of creation descending
        read_notification_1 = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
        read_notification_2 = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
        read_notifications = [read_notification_2, read_notification_1]
        get :index
        expect(assigns[:read_notifications]).to eq(read_notifications)
      end
    end

    context "notifications do not exist" do
      it "should assign @unread_notifications to be empty list" do
        get :index
        expect(assigns[:unread_notifications]).to eq([])
      end

      it "should assign @read_notifications to be empty list" do
        get :index
        expect(assigns[:read_notifications]).to eq([])
      end
    end

    context "should respond to ajax with json or script" do
      it "should return the number of unread notifications for the current user" do
        # Note these need to be in order of creation descending
        unread_notification_1 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notification_2 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notifications = [unread_notification_2, unread_notification_1]
        xhr :get, :index, format: :json
        expect(response.body).to eq(unread_notifications.length.to_s)
      end

      it "should return max of 5 unread notifications" do
        7.times{
          FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        }
        xhr :get, :index, format: :js
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(assigns[:unread_notifications]).to_not be_nil
        expect(assigns[:unread_notifications].length).to eq(5)
      end

      it "should return all unread notifications if less than 5 exist" do
        3.times{
          FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        }
        xhr :get, :index, format: :js
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(assigns[:unread_notifications]).to_not be_nil
        expect(assigns[:unread_notifications].length).to eq(3)
      end

    end

  end

  describe "PUT #toggle_read_status" do
    before(:each) do
      @user = FactoryGirl.create(:user, role: 'both')
      @user.confirmed_at = Time.now
      @user.save!
      sign_in :user, @user
    end

    it "should return http success with a valid id" do
      notification = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
      xhr :put, :toggle_read_status, id: notification.id
      expect(response).to have_http_status(:success)
    end

    it "should return http bad request with invalid id" do
      xhr :put, :toggle_read_status, id: '1000'
      expect(response).to have_http_status(:bad_request)
    end

    it "should update a read notification to unread with valid id" do
      read_notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
      expect(read_notification.read).to be(true)
      xhr :put, :toggle_read_status, id: read_notification.id
      expect(assigns[:notification].read).to be(false)
    end

    it "should update an unread notification to read with valid id" do
      unread_notification = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
      expect(unread_notification.read).to be(false)
      xhr :put, :toggle_read_status, id: unread_notification.id
      expect(assigns[:notification].read).to be(true)
    end

    it "should not toggle read status with blank id" do
      notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
      expect(notification.read).to be(true)
      xhr :put, :toggle_read_status, id: ''
      expect(assigns[:notification]).to be_nil
      expect(notification.read).to be(true)
    end

    it "should not toggle read status with non existent id" do
      notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
      expect(notification.read).to be(true)
      # There's only 1 notification in the db
      xhr :put, :toggle_read_status, id: '1000'
      expect(assigns[:notification]).to be_nil
      expect(notification.read).to be(true)
    end

    it "should not toggle read status when the current user is not the same as the user on the notification" do
      # The current user is @user, while the user associated w/ the notification is second_user. @user is trying to modify
      # a notification that does not belong to them
      second_user = FactoryGirl.create(:user, role: 'both', email: 'myseconduser@hourli.com')
      second_user.confirmed_at = Time.now
      second_user.save!
      notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: second_user)
      expect(notification.read).to be(true)
      xhr :put, :toggle_read_status, id: notification.id
      expect(notification.read).to be(true)
    end

  end

end
