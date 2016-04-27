require 'rails_helper'

RSpec.describe JobRequestsController, type: :controller do
render_views
 	before(:each) do
        @user = FactoryGirl.create(:user)
        @user.confirmed_at = Time.now
        @user.save!
        sign_in :user, @user


      #created to test the authentication process
      request_2_attrs=FactoryGirl.attributes_for :job_request
      request_2_attrs["title"] = "recorder"
      request_2_attrs["description"]="multiple sentences."
      request_2_attrs["location"] = "Binghamton"
      request_2_attrs["hourly_rate"] = 31.2
      request_2_attrs["categories"] = "Recording"
      request_2_attrs["customer_id"]=2
      @job_request_2 = FactoryGirl.create(:job_request, request_2_attrs)
        
    end

 describe "POST #create" do
 
 		it "should create a job request in the database, have a customer associated with it, display a flash message, and redirect to the show job request page" do
 			@job_request_attributes=FactoryGirl.attributes_for :job_request
 			post :create, :job_request => @job_request_attributes
 			expect(JobRequest.find_by_title(@job_request_attributes[:title])).not_to be_nil
 			expect(JobRequest.find_by_title(@job_request_attributes[:title]).customer_id).not_to be_nil
 			expect(flash[:notice]).to eq("A new job request was successfully created")
 			expect(response).to redirect_to job_request_path(JobRequest.find_by_title(@job_request_attributes[:title]))
 			
 		end

 		it "shouldn't create a new job in the database, and errors for blank fields should be displayed" do
          post :create, :job_request => {:title => '', :description => '', :location => '', :hourly_rate=> '', :categories=> ''}
          errorArray = ["Title can't be blank", "Description can't be blank", "Location can't be blank", "Hourly rate can't be blank", "Categories can't be blank"]
          expect(assigns[:job_request].valid?).to eq(false)
          expect(assigns[:job_request].errors.full_messages).to match_array(errorArray)
          expect(response).to render_template(:new)
        end 
 
 end


   describe "GET #show" do
    before do
      @job_request = FactoryGirl.create(:job_request)
    end
    it "should display the job request attributes" do
      get :show, {:id => @job_request.id}
      expect(assigns[:job_request].title).to eq(@job_request.title)
      expect(assigns[:job_request].description).to eq(@job_request.description)
      expect(assigns[:job_request].location).to eq(@job_request.location)
      expect(assigns[:job_request].hourly_rate).to eq(@job_request.hourly_rate)
      expect(assigns[:job_request].categories).to eq(@job_request.categories)

    end
  
  end


 describe "Get #edit" do
 	before do
      @job_request = FactoryGirl.create(:job_request)

    end
    it "should render the edit page when currest user is the owner of the job request" do
      get :edit, :id => @job_request.id
      expect(response).to render_template(:edit)
      expect(response.body).to include(@job_request[:title])
    end

    it "should display a alert message, and go back to the customers index page" do
      get :edit, :id => @job_request_2.id
      expect(flash[:alert]).to eq("You do not have permission to be here")
      expect(response).to redirect_to(customers_path)
    end

 end


 describe "PATCH #update" do
 	before do
      @job_request = FactoryGirl.create(:job_request)
    end
    it "should update an attribute for an existing object" do
        patch :update, :id => @job_request.id, :job_request => {:location => "New Street"}
        expect(JobRequest.find(@job_request.id).location).to eq("New Street")
        expect(flash[:notice]).to eq("The job request was successfully updated.")
        expect(response).to redirect_to(job_request_path(@job_request))
    end

    it "should display a alert message, and go back to the customers index page" do
      patch :update, :id => @job_request_2.id, :job_request => {:location => "New Street"}
      expect(flash[:alert]).to eq("You do not have permission to be here")
      expect(response).to redirect_to(customers_path)
    end
  end

    describe "DELETE #destroy" do
    before(:each) do
      @job_request = FactoryGirl.create(:job_request)
    end
    
    it "should delete a job request with the given id in the database, display a flash message, and redirect to the index page" do
        delete :destroy, :id => @job_request.id
        expect(JobRequest.exists?(@job_request.id)).to be_falsy
        expect(flash[:notice]).to eq("The job request was successfully deleted.")
        expect(response).to redirect_to(job_requests_path)
    end

      it "should display a alert message, and go back to the customers index page" do
      delete :destroy, :id => @job_request_2.id
      expect(flash[:alert]).to eq("You do not have permission to be here")
      expect(response).to redirect_to(customers_path)
  end
end


end
