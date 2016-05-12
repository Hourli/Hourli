require 'rails_helper'

RSpec.describe ContractorsController, type: :controller do
  describe "POST create" do
    before(:each) do
      @user = FactoryGirl.create(:customer_user)
      @user.confirmed_at = Time.now
      @user.save!
      sign_in :user, @user
    end
    context "it should create a contractor" do
      before do
        post :create
      end
      it "should create a contractor" do
        expect(@user.contractor).not_to be_nil
      end
    end
  end
end
