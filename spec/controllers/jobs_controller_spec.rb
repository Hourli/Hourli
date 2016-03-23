require 'rails_helper'

RSpec.describe JobsController, type: :controller do
    before(:each) do
        @user = FactoryGirl.create(:user)
        @user.confirmed_at = Time.now
        @user.save!
        sign_in :user, @user
        
    end
     describe "POST #create" do
      it "should create a new job in the database, display a flash message, and redirect to the created job" do
        job_name = "Electric - Martino Way"
        post :create, :job => {:name => job_name, :description => 'Replace ceiling fans in bedrooms', :location => "16 Martino Way, Pomona NY, 10970", :start_date=> '2015-05-05', :end_date => '2015-05-10'}
        expect(flash[:notice]).to eq("#{job_name} was successfully created.")
        expect(response).to redirect_to(assigns[:job])
      end
      it "shouldn't create a new job in the database, and errors for blank fields should be displayed" do
           post :create, :job => {:name => '', :description => '', :location => "", :start_date=> '', :end_date => ''}
          errorArray = ["Name can't be blank", "Description can't be blank", "Location can't be blank", "Start date can't be blank", "End date can't be blank"]
          expect(assigns[:job].valid?).to eq(false)
          expect(assigns[:job].errors.full_messages).to match_array(errorArray)
          expect(response).to render_template(:new)
      end  
  end
  
  describe "GET #show" do
    before(:each) do
      @job = FactoryGirl.create(:job)
    end
    
    it "should display the job attributes" do
      get :show, {:id => @job.id}
      expect(assigns[:job].name).to eq(@job.name)
      expect(assigns[:job].description).to eq(@job.description)
      expect(assigns[:job].location).to eq(@job.location)
      expect(assigns[:job].start_date).to eq(@job.start_date)
      expect(assigns[:job].end_date).to eq(@job.end_date)
    end
  
  end

end
