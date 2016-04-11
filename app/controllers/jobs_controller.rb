class JobsController < ApplicationController
    #before_action :auth, except: [:show]
    
    def index
        @jobs = Job.all
    end
    
    def new
        @job = Job.new
    end
    
    def edit
    @job = Job.find(params[:id])
    end
    
    def create
        @job = Job.create(job_params)
        if @job.valid?
            flash[:notice] = "#{@job.name} was successfully created."
            redirect_to @job
        else
            #puts @job.errors.full_messages
            #redirect_to new_job_path(@job)
            render :new
        end
    end
    
    def update
     @job = Job.find(params[:id])
 
    if @job.update(job_params)
      redirect_to @job
     else
      render 'edit'
    end
    end
    
    def show
        @job = Job.find(params[:id])
    end
    
    private
     def job_params
      params.require(:job).permit(:name, :description, :location, :start_date, :end_date)
     end
     
     #def auth
        #if current_user.role == 'customer'
            #flash[:alert] = "Please switch to contractor"
            #redirect_to root_path
        #end
     #end
    
end
