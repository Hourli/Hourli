class JobRequestsController < ApplicationController
	before_action :retrieve_job_request, only: [:edit, :update, :destroy]
	before_action :restrict_to_owner, only: [:edit, :update, :destroy]

	def index
		@job_requests = current_user.customer.job_requests
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
	if @job_request.customer_id != current_user.customer.id

		flash[:alert] = "You do not have permission to be here"
		redirect_to customers_path
	end

end

def show
	@job_request = JobRequest.find(params[:id])
end

def update

	     #authentication_before_action
	     # if @job_request.customer_id != current_user.customer.id

	     # 	flash[:alert] = "You do not have permission to be here"
	     # 	redirect_to customers_path
	     # else
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

def search
	if params[:q].present? and params[:q] != ""
		@job_requests = JobRequest.search(params[:q]).page(params[:page]).records
	end
end

private
def job_request_params
	params.require(:job_request).permit(:title, :description, :location, :hourly_rate, :categories)
end
def restrict_to_owner
	if @job_request.customer != current_user.customer
		flash[:alert] = "You do not have permission to be here"
		redirect_to customers_path
	end
end

def retrieve_job_request
	@job_request = JobRequest.find_by(id: params[:id])
	if @job_request.nil?
		flash[:alert] = "Invalid job offer id #{params[:id]}"
		redirect_to customers_path
	end
end

