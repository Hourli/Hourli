require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user, role: 'both')
    @user.role = 'contractor'
    @user.confirmed_at = Time.now
    @user.save!
    sign_in :user, @user

    job_attrs = FactoryGirl.attributes_for :job
    job_attrs["name"] = 'Electric - Martino Way'
    job_attrs["description"] = 'Replace ceiling fans in bedrooms'
    job_attrs["location"] = '16 Martino Way, Pomona NY, 10970'
    job_attrs["start_date"] = '2015-05-05'
    job_attrs["end_date"] = '2015-05-10'
    job_attrs["contractor"] = @user.contractor
    @job = FactoryGirl.create(:job, job_attrs)
  end

  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #new" do
    context "valid job id" do
      it "returns http success" do
        get :new, {job_id: @job.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the new template" do
        get :new, {job_id: @job.id}
        expect(response).to render_template(:new)
      end

      it "should assign @job and @task" do
        get :new, {job_id: @job.id}
        expect(assigns[:job]).to eq(@job)
        expect(assigns[:task]).to_not be_nil
      end
    end

    context "invalid job id" do
      it "should redirect to root path and display flash message" do
        get :new, {job_id: 4}
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Invalid job id 4")
      end
    end

    context "current role is not contractor" do
      it "should redirect and show flash message when current role is not contractor" do
        @user.role = 'customer'
        @user.save!
        get :new, {job_id: @job.id}
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You do not have permission to be here, switch to your contractor account and try again')
      end
    end

  end

  describe "POST #create" do
    it "redirects to the job edit page on successful POST" do
      post :create, {job_id: @job.id, task: {title: "dsf"}}
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(edit_job_path(@job.id))
    end

    it "validates presence of title" do
      post :create, {job_id: @job.id, task: {title:''}}
      expect(response).to render_template(:new)
    end

    it "creates a new task" do
      post :create, {job_id: @job.id, task: {title:'MyTitle', description: 'MyDescription', duration: 3, completed: false}}
      expect(flash[:notice]).to eq('MyTitle successfully created')
      expect(assigns[:task]).not_to be_nil
      expect(response).to redirect_to(edit_job_path(@job.id))
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: @job.id)
      get :edit, {job_id: @job.id, id: @task.id}
      expect(response).to have_http_status(:success)
    end

    it "should render the edit template" do
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: @job.id)
      get :edit, {job_id: @job.id, id: @task.id}
      expect(response).to render_template(:edit)
    end

    it "should assign task and job" do
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: @job.id)
      get :edit, {job_id: @job.id, id: @task.id}
      expect(assigns[:task]).not_to be_nil
      expect(assigns[:job]).not_to be_nil
    end

    it "should not allow editing when the current user is not the same as the user on the job" do
      second_user = FactoryGirl.create(:user, role: 'both', email: 'myseconduser@hourli.com')
      second_user.role = 'contractor'
      second_user.save!
      job = FactoryGirl.create(:job, name: "MyJob", description: "MyDescription", location: "MyLocation", start_date: "2015-05-05", end_date: "2015-05-10", contractor: second_user.contractor)
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: job.id)
      expect(@task.title).to eq("MyTitle")
      get :edit, {job_id: job.id, id: @task.id}
      expect(@task.title).to eq("MyTitle")
      expect(flash[:alert]).to eq("You do not have permission to perform this action")
      expect(response).to redirect_to(root_path)
    end

  end

  describe "PATCH #update" do
    it "returns http redirect" do
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: @job.id)
      patch :update, {job_id: @job.id, id: @task.id, task: {title: "MyNewTitle"}}
      expect(response).to have_http_status(:redirect)
    end

    it "should update the task" do
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: @job.id)
      patch :update, {job_id: @job.id, id: @task.id, task: {title: "MyNewTitle"}}
      expect(assigns[:task].title).to eq("MyNewTitle")
      expect(flash[:notice]).to eq("Task successfully updated")
    end

    it "should render edit on invalid id" do
      patch :update, {job_id: @job.id, id: 2222, task: {title: "MyNewTitle"}}
      expect(response).to render_template(:edit)
    end

    it "should not allow editing when the current user is not the same as the user on the job" do
      second_user = FactoryGirl.create(:user, role: 'both', email: 'myseconduser@hourli.com')
      second_user.role = 'contractor'
      second_user.save!
      job = FactoryGirl.create(:job, name: "MyJob", description: "MyDescription", location: "MyLocation", start_date: "2015-05-05", end_date: "2015-05-10", contractor: second_user.contractor)
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: job.id)
      expect(@task.title).to eq("MyTitle")
      get :edit, {job_id: job.id, id: @task.id}
      expect(@task.title).to eq("MyTitle")
      expect(flash[:alert]).to eq("You do not have permission to perform this action")
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #destroy" do
    it "returns http redirect" do
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: @job.id)
      delete :destroy, {job_id: @job.id, id: @task.id}
      expect(response).to have_http_status(:redirect)
    end

    it "deletes the task" do
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: @job.id)
      delete :destroy, {job_id: @job.id, id: @task.id}
      expect(Task.find_by(id: @task.id)).to be_nil
      expect(flash[:notice]).to eq("#{@task.title} successfully deleted")
    end

    it "should not allow delete when the current user is not the same as the user on the job" do
      second_user = FactoryGirl.create(:user, role: 'both', email: 'myseconduser@hourli.com')
      second_user.role = 'contractor'
      second_user.save!
      job = FactoryGirl.create(:job, name: "MyJob", description: "MyDescription", location: "MyLocation", start_date: "2015-05-05", end_date: "2015-05-10", contractor: second_user.contractor)
      @task = FactoryGirl.create(:task, title: "MyTitle", description: "MyDescription", completed: true, duration: 3, job_id: job.id)
      expect(@task.title).to eq("MyTitle")
      delete :destroy, {job_id: job.id, id: @task.id}
      expect(@task.title).to eq("MyTitle")
      expect(flash[:alert]).to eq("You do not have permission to perform this action")
      expect(response).to redirect_to(root_path)
    end

  end

end
