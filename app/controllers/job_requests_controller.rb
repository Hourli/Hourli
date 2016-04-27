class JobRequestsController < ApplicationController

def index
	
end
def create
	@job_request=JobRequest.create(job_request_params)
	# current_user.job_requests.new
	if @job_request.valid?
		flash[:notice] = "A new job request was successfully created"
		@job_request.customer=current_user.customer
		@job_request.save
		redirect_to @job_request
	else
		#flash[:notice] = "Fail to create a job request: missing fields"
		render :new
		puts @job_request.errors.full_messages
		
		
	end

end
def new
	@job_request = JobRequest.new
end
def edit	
    @job_request = JobRequest.find(params[:id])
	#puts "***************"
 	#puts @job_request.customer_id
 	#puts current_user.customer.id
	#puts "$$$$$$$$$$$$$$$$"
    #authentication_before_action
    if @job_request.customer_id != current_user.customer.id

    	flash[:alert] = "You do not have permission to be here"
    	redirect_to customers_path
   end

end
def show
	@job_request = JobRequest.find(params[:id])

end
def update
	@job_request = JobRequest.find(params[:id])

	     #authentication_before_action
    if @job_request.customer_id != current_user.customer.id

    	flash[:alert] = "You do not have permission to be here"
    	redirect_to customers_path
    else


		@job_request.update_attributes(job_request_params)
    	if @job_request.valid?
    	flash[:notice] = "The job request was successfully updated."
    	@job_request.save
    	redirect_to job_request_path(@job_request)
		else
	  	render :edit
	  	puts @job_request.errors.full_messages
		end
	end

end
def destroy
	@job_request = JobRequest.find(params[:id])

	#authentication_before_action
    if @job_request.customer_id != current_user.customer.id

    	flash[:alert] = "You do not have permission to be here"
    	redirect_to customers_path
    else


    	@job_request.destroy
    	flash[:notice] = "The job request was successfully deleted."
    	redirect_to job_requests_path
    end


end

	



	private
		def job_request_params
			params.require(:job_request).permit(:title, :description, :location, :hourly_rate, :categories)
		end
	
end
