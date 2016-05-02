class CustomersController < ApplicationController

  def index
    
  end

  def create
    current_user.customer = Customer.create()
    redirect_to edit_user_registration_path
  end

  def dashboard
    @job_requests = current_user.customer.job_requests
  end

end
