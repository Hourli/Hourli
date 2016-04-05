require 'rails_helper'

RSpec.describe ChangeRolesController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user, role: 'both')
    @user.confirmed_at = Time.now
    @user.save!
  end
  describe "GET #change_role", js: true do
    it "should change the current user's role from customer to contractor " do
      @user.role = 'customer'
      @user.save!
      sign_in :user, @user

      expect(controller.current_user.role).to eq('customer')
      xhr :get, :change_role
      expect(response).to have_http_status(:success)
      expect(controller.current_user.role).to eq('contractor')
    end

    it "should change the current user's role from contractor to customer" do
      @user.role = 'contractor'
      @user.save!
      sign_in :user, @user

      expect(controller.current_user.role).to eq('contractor')
      xhr :get, :change_role
      expect(response).to have_http_status(:success)
      expect(controller.current_user.role).to eq('customer')
    end


    it "should not change the current user's role from customer to contractor if the current user doesn't have an associated contractor object" do
      @user.role = 'customer'
      @user.save!
      sign_in :user, @user
      @user.contractor = nil
      @user.save!
      xhr :get, :change_role
      expect(response).to have_http_status(:bad_request)
      expect(controller.current_user.role).to eq('customer')
    end

    it "should not change the current user's role from contractor to customer if the current user doesn't have an associated customer object" do
      @user.role = 'contractor'
      @user.save!
      sign_in :user, @user
      @user.customer = nil
      @user.save!
      xhr :get, :change_role
      expect(response).to have_http_status(:bad_request)
      expect(controller.current_user.role).to eq('contractor')
    end

    it "should not change the current user's role if the current user doesn't have an associated customer and contractor object" do
      @user.role = 'invalidrolefortesting'
      @user.save!
      sign_in :user, @user
      @user.customer = nil
      @user.contractor = nil
      xhr :get, :change_role
      expect(response).to have_http_status(:bad_request)
      expect(controller.current_user.role).to eq('invalidrolefortesting')
    end
  end
end
