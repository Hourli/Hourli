class JobsController < ApplicationController

  def index
    #@jobs = Job.all
    @jobs = current_user.contractor.jobs.all
    @completed_jobs = current_user.contractor.jobs.where(completed: false)
    @ongoing_jobs = current_user.contractor.jobs.where(completed: true)
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
      @job.contractor= current_user.contractor
      @job.save
      redirect_to @job
    else
      #puts @job.errors.full_messages
      #redirect_to new_job_path(@job)
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    puts params[:completed]

    if @job.update(job_params)
      flash[:notice] = "The job was successfully updated"
      redirect_to @job
    else
      render 'edit'
    end
  end

  def show
    @job = Job.find(params[:id])
    @tasks = @job.tasks.all unless @job.nil?
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = "The job was successfully deleted"
    redirect_to jobs_path
  end

  private
  def job_params
    params.require(:job).permit(:name, :description, :location, :start_date, :end_date, :completed)
  end

end
