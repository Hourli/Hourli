require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "retrieving notifications for the current user" do
    before(:each) do
      @user_1 = FactoryGirl.create(:user, role: 'both')
      @user_1.confirmed_at = Time.now
      @user_1.save!

      @user_2 = FactoryGirl.create(:user, role: 'both', email: 'myseconduser@hourli.com')
      @user_2.confirmed_at = Time.now
      @user_2.save!

      @user_1_unread_notifications = FactoryGirl.create_list(:notification, 4, read: false, notification_for: 'customer', user: @user_1)
      @user_2_unread_notification =  FactoryGirl.create(:notification, read: false, notification_for: 'customer', user: @user_2)

      @user_1_read_notifications = FactoryGirl.create_list(:notification, 4, read: true, notification_for: 'customer', user: @user_1)
      @user_2_read_notification =  FactoryGirl.create(:notification, read: true, notification_for: 'customer', user: @user_2)
    end

    it "should fetch all unread notifications for the current user" do
      result = @user_1.notifications.where(read: false)
      expect(result).to match_array(@user_1_unread_notifications)
      expect(result).to_not include(@user_2_unread_notification)
    end

    it "should fetch all read notifications for the current user" do
      result = @user_1.notifications.where(read: true)
      expect(result).to match_array(@user_1_read_notifications)
      expect(result).to_not include(@user_2_read_notification)
    end
  end

  describe "validations" do
    before(:each) do
      @user_1 = FactoryGirl.create(:user, role: 'both')
      @user_1.confirmed_at = Time.now
      @user_1.save!
    end

    it "should validate the presence of message" do
      expect {Notification.create!(user: @user_1, notification_for: 'customer')}.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: Message can't be blank")
    end

    it "should validate the presence of notification_for" do
      expect {Notification.create!(user: @user_1, message: 'mymessage')}.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it "should validate the presence of a user" do
      expect {Notification.create!(message: 'mymessage', notification_for: 'customer')}.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: User can't be blank")
    end

    it "should only allow 'customer' or 'contractor' for notification_for" do
      test_cases = ['fsadfsadfs', '!@#$%^&*()_', 'custome', 'ontractor', 'customera', '  customer']
      test_cases.each do |test_case|
        expect{Notification.create!(user: @user_1, message: 'mymessage', notification_for: test_case)}.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end
end
