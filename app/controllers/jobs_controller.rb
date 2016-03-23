class JobsController < ApplicationController
    
    def new
        @job = Job.new
    end
    
    def create
        
        if Job.create!(job_params).valid?
            @job = Job.create!(job_params)
            flash[:notice] = "#{@job.name} was successfully created."
            redirect_to @job
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
