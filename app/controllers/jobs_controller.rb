class JobsController < ApplicationController
    
    def new
        @job = Job.new
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
    
    def show
        @job = Job.find(params[:id])
    end
    
    private
     def job_params
      params.require(:job).permit(:name, :description, :location, :start_date, :end_date)
     end
    
end
