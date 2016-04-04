require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Signing up for an account" do
      
      context "signing up as a customer" do
          it "should create a customer object and associate it with the current user" do
              @user = FactoryGirl.create(:user, role: "customer")
              @customer = Customer.find_by_user_id(@user)
              expect(@user.role).to eq("customer")
              expect(@user.customer).to_not be_nil
              expect(@user.customer.id).to eq(@customer.id)
              expect(@customer.user.id).to eq(@user.id)
          end
      end
      
      context "signing up as a contractor" do
          it "should create a contractor object and associate it wih the current user" do
              @user = FactoryGirl.create(:user, role: "contractor")
              @contractor = Contractor.find_by_user_id(@user)
              expect(@user.role).to eq("contractor")
              expect(@user.contractor).to_not be_nil
              expect(@user.contractor.id).to eq(@contractor.id)
              expect(@contractor.user.id).to eq(@user.id)
          end
      end
      
      context "signing up as both a customer and contractor" do
          it "should create a customer and contractor object and associate them with the current user" do
              @user = FactoryGirl.create(:user, role: "both")
              
              @customer = Customer.find_by_user_id(@user)
              expect(@user.customer).to_not be_nil
              expect(@user.customer.id).to eq(@customer.id)
              expect(@customer.user.id).to eq(@user.id)
              
              @contractor = Contractor.find_by_user_id(@user)
              expect(@user.contractor).to_not be_nil
              expect(@user.contractor.id).to eq(@contractor.id)
              expect(@contractor.user.id).to eq(@user.id)
              
              # In this case we will default to the customer role
              expect(@user.role).to eq("customer")
          end
      end
     
     context "signing up with an invalid role" do
         it "should just default to creating a customer" do
              @user = FactoryGirl.create(:user, role: "abcdef")
              @customer = Customer.find_by_user_id(@user)
              expect(@user.role).to eq("customer")
              expect(@user.customer).to_not be_nil
              expect(@user.customer.id).to eq(@customer.id)
              expect(@customer.user.id).to eq(@user.id)
         end
     end
  end
end
