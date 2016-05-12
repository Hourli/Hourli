class ContractorsController < ApplicationController

  def index
    @jobs = current_user.contractor.jobs.all
    @completed_jobs = current_user.contractor.jobs.where(completed: false)
    @ongoing_jobs = current_user.contractor.jobs.where(completed: true)
  end

  def create
    current_user.contractor = Contractor.create()
    redirect_to edit_user_registration_path
  end

  def edit
    @contractor = current_user.contractor
  end

  def update
    puts params.inspect
    contractor = current_user.contractor
    contractor.update(contractor_params)
    if contractor.save
      flash[:notice] = "Successfully updated contractor profile!"
      redirect_to edit_contractor_path
    else
      flash[:error] = contractor.errors.first
      redirect_to edit_contractor_path
    end
  end

  private
  def contractor_params
    params.require(:contractor).permit(:occupation, :location, :summary)
  end
end
