class JobRequestsController < ApplicationController
	
def index
	
end
def create
	@job_request=JobRequest.create(job_request_params)
	if @job_request.valid?
		flash[:notice] = "A new job request was successfully created"
		redirect_to @job_request
	else
		#flash[:notice] = "Fail to create a job request: missing fields"
		puts @job_request.errors.full_messages
		render :new
	end

end
def new
	@job_request = JobRequest.new
end
def edit

end
def show
	@job_request = JobRequest.find(params[:id])
end
def update

end
def destroy

end
	private
		def job_request_params
			params.require(:job_request).permit(:title, :description, :location, :hourly_rate, :categories)
		end
	
end
