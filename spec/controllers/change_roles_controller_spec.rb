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
      get :change_role, 'new_role': 'contractor', format: :json
      expect(response).to have_http_status(:success)
      expect(controller.current_user.role).to eq('contractor')
    end

    it "should change the current user's role from contractor to customer" do
      @user.role = 'contractor'
      @user.save!
      sign_in :user, @user

      expect(controller.current_user.role).to eq('contractor')
      get :change_role, 'new_role': 'customer', format: :json
      expect(response).to have_http_status(:success)
      expect(controller.current_user.role).to eq('customer')
    end

    it "should not change the current user's role when an invalid role is sent to the server" do
      @user.role = 'customer'
      @user.save!
      sign_in :user, @user
      expect(controller.current_user.role).to eq('customer')
      get :change_role, 'new_role': 'invalid-role', format: :json
      expect(response).to have_http_status(:bad_request)
      expect(controller.current_user.role).to eq('customer')
      expect(response.body).to have_content("invalid-role is not a valid role")
    end

    it "should not change the current user's role from customer to contractor if the current user doesn't have an associated contractor object" do
      @user.role = 'customer'
      @user.save!
      sign_in :user, @user
      @user.contractor = nil
      @user.save!
      get :change_role, 'new_role': 'contractor', format: :json
      expect(response).to have_http_status(:bad_request)
      expect(controller.current_user.role).to eq('customer')
      expect(response.body).to have_content("#{@user.email} does not have a valid contractor")
    end

    it "should not change the current user's role from contractor to customer if the current user doesn't have an associated customer object" do
      @user.role = 'contractor'
      @user.save!
      sign_in :user, @user
      @user.customer = nil
      @user.save!
      get :change_role, 'new_role': 'customer', format: :json
      expect(response).to have_http_status(:bad_request)
      expect(controller.current_user.role).to eq('contractor')
      expect(response.body).to have_content("#{@user.email} does not have a valid customer")
    end
  end
end
