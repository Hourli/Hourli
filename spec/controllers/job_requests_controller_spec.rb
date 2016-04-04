require 'rails_helper'

RSpec.describe JobRequestsController, type: :controller do
render_views
 describe "POST create" do
 	before(:each) do
        @user = FactoryGirl.create(:user)
        @user.confirmed_at = Time.now
        @user.save!
        sign_in :user, @user
        
    end
 	context "should create a job request"do
 		before do 
 			@job_request_attributes=FactoryGirl.attributes_for :job_request
 			post :create, :job_request => @job_request_attributes
 		end

 		it "should create a job request in the database" do
 			expect(JobRequest.find_by_title(@job_request_attributes[:title])).not_to be_nil
 		end

 		it "should redirect to the show job request page" do
 			response.should redirect_to job_request_path(JobRequest.find_by_title(@job_request_attributes[:title]))
 		end

 		it "should have a customer associated with it" do
 			expect(JobRequest.find_by_title(@job_request_attributes[:title]).customer_id).not_to be_nil
 			#puts JobRequest.find_by_title(@job_request_attributes[:title]).customer_id
 		end

 end
 end
end
