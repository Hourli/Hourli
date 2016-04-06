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
      it "should assign @unread_notifications" do
        unread_notification_1 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notification_2 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notifications = [unread_notification_1, unread_notification_2]
        expect(controller.current_user.notifications).to receive(:where).with(read: false).and_return(unread_notifications)
        expect(controller.current_user.notifications).to receive(:where).with(read: true)
        get :index
        expect(assigns[:unread_notifications]).to match_array(unread_notifications)
      end

      it "should assign @read_notifications" do
        read_notification_1 = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
        read_notification_2 = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
        read_notifications = [read_notification_1, read_notification_2]
        expect(controller.current_user.notifications).to receive(:where).with(read: true).and_return(read_notifications)
        expect(controller.current_user.notifications).to receive(:where).with(read: false)
        get :index
        expect(assigns[:read_notifications]).to match_array(read_notifications)
      end
    end

    context "notifications do not exist" do
      it "should assign @unread_notifications to be empty list" do
        expect(controller.current_user.notifications).to receive(:where).with(read: false).and_return([])
        expect(controller.current_user.notifications).to receive(:where).with(read: true)
        get :index
        expect(assigns[:unread_notifications]).to match_array([])
      end

      it "should assign @read_notifications to be empty list" do
        expect(controller.current_user.notifications).to receive(:where).with(read: true).and_return([])
        expect(controller.current_user.notifications).to receive(:where).with(read: false)
        get :index
        expect(assigns[:read_notifications]).to match_array([])
      end
    end

    context "should respond to ajax with json" do
      it "should return the number of unread notifications for the current user" do
        unread_notification_1 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notification_2 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notifications = [unread_notification_1, unread_notification_2]
        expect(controller.current_user.notifications).to receive(:where).with(read: false).and_return(unread_notifications)
        expect(controller.current_user.notifications).to receive(:where).with(read: true)
        xhr :get, :index, format: :json
        expect(response.body).to eq(unread_notifications.length.to_s)
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
      expect(response.body).to eq('successfully updated')
    end

    it "should update an unread notification to read with valid id" do
      unread_notification = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
      expect(unread_notification.read).to be(false)
      xhr :put, :toggle_read_status, id: unread_notification.id
      expect(assigns[:notification].read).to be(true)
      expect(response.body).to eq('successfully updated')
    end

    it "should not toggle read status with blank id" do
      notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
      expect(notification.read).to be(true)
      xhr :put, :toggle_read_status, id: ''
      expect(assigns[:notification]).to be_nil
      expect(notification.read).to be(true)
      expect(response.body).to eq('Invalid notification id')
    end

    it "should not toggle read status with non existent id" do
      notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
      expect(notification.read).to be(true)
      # There's only 1 notification in the db
      xhr :put, :toggle_read_status, id: '1000'
      expect(assigns[:notification]).to be_nil
      expect(notification.read).to be(true)
      expect(response.body).to eq('Invalid notification id')
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
      expect(response.body).to eq('You do not have permission to do this')
    end

  end

end
