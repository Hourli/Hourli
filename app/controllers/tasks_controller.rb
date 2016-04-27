class TasksController < ApplicationController
  before_action :restrict_to_contractors, :retrieve_job

  def index
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.job = @job
      @task.save
      flash[:notice] = "#{@task.title} successfully created"
      redirect_to edit_job_path(@job)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :duration, :completed)
  end

  def restrict_to_contractors
    if current_user.role != 'contractor'
      flash[:alert] = 'You do not have permission to be here, switch to your contractor account and try again'
      redirect_to root_path
    end
  end

  def retrieve_job
    @job = Job.find_by(id: params[:job_id])
    if @job.nil?
      flash[:alert] = "Invalid job id #{params[:job_id]}"
      redirect_to root_path
    end
  end

end
