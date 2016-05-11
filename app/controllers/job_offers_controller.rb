class JobOffersController < ApplicationController
  before_action :restrict_to_contractors, only: [:new, :create, :edit, :update, :destroy]
  before_action :retrieve_job_offer, only: [:edit, :update, :destroy, :show]
  before_action :restrict_to_owner, only: [:edit, :update, :destroy]
#  before_action :restrict_to_the_customer_and_contractor, only: [:accept]
# GET /job_offers
# GET /job_offers.json

def accept
end

def index
  #@job_offers = JobOffer.find_by(id: params[:id])
  @job_offers = JobOffer.where("job_request_id = ?", params[:job_request])
end

# GET /job_offers/1
# GET /job_offers/1.json
def show
  #@job_offer = JobOffer.find(params[:id])
end

# GET /job_offers/new
def new
  @job_offer = JobOffer.new
end

# GET /job_offers/1/edit
def edit
end

# POST /job_offers
# POST /job_offers.json
def create
  @job_offer=JobOffer.new(job_offer_params)
# current_user.job_requests.new
if @job_offer.valid?
  flash[:notice] = "A new job offer was successfully created"
  @job_offer.contractor = current_user.contractor
  @job_offer.job_request = JobRequest.find(params[:job_request])
  @job_offer.save
  redirect_to @job_offer
else
  render :new
  puts @job_offer.errors.full_messages
end

end

def update
  @job_offer.update_attributes(job_offer_params)
  if @job_offer.valid?
    flash[:notice] = "The job offer was successfully updated"
    @job_offer.save
    redirect_to job_offer_path(@job_offer)
  else
    render :edit
    puts @job_offer.errors.full_messages
  end
end

# DELETE /job_offers/1
# DELETE /job_offers/1.json
def destroy
  @job_offer.destroy
  redirect_to :root
end

def accept
    @job_offer = JobOffer.find_by(id: params[:id])
    #use job request's name     description   location   start_date??  end_date??      contractor that the offer belongs to
    #the job belongs to the contractor and the customer
    @job_request = @job_offer.job_request
    @job=Job.create(name: @job_request[:title], description: @job_request[:description], location: @job_request[:location], start_date: @job_request[:start_date], end_date: @job_request[:end_date], completed: false)
    @job.customer=current_user.customer
    @job.contractor=@job_offer.contractor

    @job.save
    #puts "@@@@@@@@@@@"
    #puts @job.errors.full_messages
    #puts Job.find_by(name: @job_request[:title])
    #puts "########"

    #delete the job request and all the job offers that belong to the job request
    JobOffer.where(job_request: @job_request).each { |offer|
        offer.destroy
    } 
    @job_request.destroy
    

    #send a message to both the customer and the chosen contractor
    flash[:notice]= "You have accepted the job offer, job #{@job.name} is generated."
    redirect_to :root
   
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_job_offer
    @job_offer = JobOffer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_offer_params
    params.require(:job_offer).permit(:title, :description, :hourly_rate)
  end

  def restrict_to_contractors
    if current_user.role != 'contractor'
      flash[:alert] = 'You do not have permission to be here, switch to your contractor account and try again'
      redirect_to :back
    end
  end

  def restrict_to_owner
    if @job_offer.contractor != current_user.contractor
      flash[:alert] = "You do not have permission to perform this action"
      redirect_to :back
    end
  end

  def retrieve_job_offer
    @job_offer = JobOffer.find_by(id: params[:id])
    if @job_offer.nil?
      flash[:alert] = "Invalid job offer id #{params[:id]}"
      redirect_to :root
    end
  end

end
