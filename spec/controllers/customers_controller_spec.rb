require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe "POST create" do
    before(:each) do
      @user = FactoryGirl.create(:contractor_user)
      @user.confirmed_at = Time.now
      @user.save!
      sign_in :user, @user
    end
    context "it should create a customer" do
      before do
        post :create
      end
      it "should create a customer" do
        expect(@user.customer).not_to be_nil
      end
    end
  end
end
