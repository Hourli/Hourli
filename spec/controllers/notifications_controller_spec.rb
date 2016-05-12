require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create(:user, role: 'both')
      @user.confirmed_at = Time.now
      @user.save!
      sign_in :user, @user
    end

    describe "as HTML" do

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

        it "should not show any hidden unread notifications" do
          hidden_notification_1 = FactoryGirl.create(:notification, read: false, hidden: true, notification_for: 'customer', user: @user)
          unread_notification_2 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
          unread_notifications = [unread_notification_2]
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

        it "should not show any hidden read notifications" do
          hidden_notification_1 = FactoryGirl.create(:notification, read: true, hidden: true, notification_for: 'customer', user: @user)
          read_notification_2 = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
          read_notifications = [read_notification_2]
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
    end

    describe "as ajax or json" do
      it "should return the number of unread notifications for the current user" do
        # Note these need to be in order of creation descending
        unread_notification_1 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notification_2 = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        unread_notifications = [unread_notification_2, unread_notification_1]
        xhr :get, :index, format: :json
        expect(response.body).to eq(unread_notifications.length.to_s)
      end

      it "should return max of 5 unread notifications" do
        7.times {
          FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        }
        xhr :get, :index, format: :js
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(assigns[:unread_notifications]).to_not be_nil
        expect(assigns[:unread_notifications].length).to eq(5)
      end

      it "should return all unread notifications if less than 5 exist" do
        3.times {
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

    context "only one id" do
      it "should return http success with a valid id" do
        notification = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        xhr :put, :toggle_read_status, id: notification.id
        expect(response).to have_http_status(:success)
      end

      it "should return http bad request with invalid id" do
        xhr :put, :toggle_read_status, id: '1000'
        expect(response).to have_http_status(:bad_request)
        expect(assigns[:notifications]).to be_nil
      end

      it "should update a read notification to unread with valid id" do
        read_notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
        expect(read_notification.read).to be(true)
        xhr :put, :toggle_read_status, id: read_notification.id
        assigns[:notifications].each { |notification|
          expect(notification.read).to be(false)
        }
      end

      it "should update an unread notification to read with valid id" do
        unread_notification = FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user)
        expect(unread_notification.read).to be(false)
        xhr :put, :toggle_read_status, id: unread_notification.id
        assigns[:notifications].each { |notification|
          expect(notification.read).to be(true)
        }
      end

      it "should not toggle read status with blank id" do
        notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
        expect(notification.read).to be(true)
        xhr :put, :toggle_read_status, id: ''
        expect(assigns[:notification]).to be_nil
        expect(response).to have_http_status(:bad_request)
        expect(notification.read).to be(true)
      end

      it "should not toggle read status with non existent id" do
        notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
        expect(notification.read).to be(true)
        # There's only 1 notification in the db
        xhr :put, :toggle_read_status, id: '1000'
        expect(assigns[:notification]).to be_nil
        expect(response).to have_http_status(:bad_request)
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

    context "multiple ids" do
      it "should toggle read status for multiple ids" do
        notifications = FactoryGirl.create_list(:notification, 3, read: false, user: @user, notification_for: 'customer')
        ids = notifications.map { |notification| notification.id }
        xhr :put, :toggle_read_status, id: ids
        assigns[:notifications].each { |notification|
          expect(notification.read).to be(true)
        }
      end

      it "should return http success with multiple valid ids" do
        notifications = FactoryGirl.create_list(:notification, 3, read: false, user: @user, notification_for: 'customer')
        ids = notifications.map { |notification| notification.id }
        xhr :put, :toggle_read_status, id: ids
        expect(response).to have_http_status(:success)
      end

      it "should return http bad request if any id is invalid" do
        notification = FactoryGirl.create(:notification, read: false, user: @user, notification_for: 'customer')
        xhr :put, :toggle_read_status, id: "1000, #{notification.id}"
        expect(response).to have_http_status(:bad_request)
        expect(assigns[:notifications]).to be_nil
      end

      it "should update multiple read notifications to unread with valid ids" do
        notifications = FactoryGirl.create_list(:notification, 3, read: true, user: @user, notification_for: 'customer')
        ids = notifications.map { |notification| notification.id }
        notifications.each { |notification|
          expect(notification.read).to be(true)
        }
        xhr :put, :toggle_read_status, id: ids
        assigns[:notifications].each { |notification|
          expect(notification.read).to be(false)
        }
      end

      it "should update multiple unread notifications to read with valid ids" do
        notifications = FactoryGirl.create_list(:notification, 3, read: false, user: @user, notification_for: 'customer')
        ids = notifications.map { |notification| notification.id }
        notifications.each { |notification|
          expect(notification.read).to be(false)
        }
        xhr :put, :toggle_read_status, id: ids
        assigns[:notifications].each { |notification|
          expect(notification.read).to be(true)
        }
      end

      it "should not toggle read status with blank id" do
        xhr :put, :toggle_read_status, id: "' ',' '"
        expect(assigns[:notifications]).to be_nil
        expect(response).to have_http_status(:bad_request)
      end

      it "should not toggle read status with non existent ids" do
        notification = FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user)
        expect(notification.read).to be(true)
        # There's only 1 notification in the db
        xhr :put, :toggle_read_status, id: '1000,2000'
        expect(assigns[:notifications]).to be_nil
        expect(response).to have_http_status(:bad_request)
      end

      it "should not toggle read status when the current user is not the same as the user on the notification" do
        # The current user is @user, while the user associated w/ the notification is second_user. @user is trying to modify
        # a notification that does not belong to them
        second_user = FactoryGirl.create(:user, role: 'both', email: 'myseconduser@hourli.com')
        second_user.confirmed_at = Time.now
        second_user.save!
        notification_list = FactoryGirl.create_list(:notification, 4, read: true, notification_for: 'customer', user: second_user)
        ids = notification_list.map { |notification| notification.id }
        notification_list.each { |notification|
          expect(notification.read).to be(true)
        }
        xhr :put, :toggle_read_status, id: ids
        expect(assigns[:notifications]).to be_nil
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "PUT #hide" do
    before(:each) do
      @user = FactoryGirl.create(:user, role: 'both')
      @user.confirmed_at = Time.now
      @user.save!
      sign_in :user, @user
    end

    it "should return http redirect with a valid id" do
      notification = FactoryGirl.create(:notification, read: false, hidden: false, notification_for: 'customer', user: @user)
      put :hide, id: notification.id
      expect(response).to have_http_status(:found)
    end

    it "should return http bad request with non existent id" do
      put :hide, id: '1000'
      expect(response).to have_http_status(:bad_request)
    end

    it "should return http bad request with blank id" do
      put :hide, id: ''
      expect(response).to have_http_status(:bad_request)
    end

    it "should make the specified notification hidden with valid id" do
      notification = FactoryGirl.create(:notification, read: false, hidden: false, notification_for: 'customer', user: @user)
      expect(notification.hidden).to be(false)
      put :hide, id: notification.id
      expect(@user.notifications.find_by(id: notification.id).hidden).to be(true)
    end

    it "should not hide the notification when the current user is not the same as the user on the notification" do
      # The current user is @user, while the user associated w/ the notification is second_user. @user is trying to modify
      # a notification that does not belong to them
      second_user = FactoryGirl.create(:user, role: 'both', email: 'myseconduser@hourli.com')
      second_user.confirmed_at = Time.now
      second_user.save!
      notification = FactoryGirl.create(:notification, read: false, hidden: false, notification_for: 'customer', user: second_user)
      expect(notification.hidden).to be(false)
      put :hide, id: notification.id
      expect(second_user.notifications.find_by(id: notification.id).hidden).to be(false)
    end
  end

end
