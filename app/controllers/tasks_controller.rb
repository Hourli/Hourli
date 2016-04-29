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
    @task = Task.find_by(id: params[:id])
    if @job.contractor != current_user.contractor
      flash[:alert] = "You do not have permission to perform this action"
      redirect_to root_path
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @job.contractor != current_user.contractor
      flash[:alert] = "You do not have permission to perform this action"
      redirect_to root_path
    end
    if not @task.nil? and @task.update(task_params)
      flash[:notice] = "Task successfully updated"
      redirect_to edit_job_task_path(@job, @task)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    path = edit_job_path(@job)
    if @job.contractor != current_user.contractor
      flash[:alert] = "You do not have permission to perform this action"
      path = root_path
    end
    @task.destroy
    flash[:notice] = "#{@task.title} successfully deleted"
    redirect_to path
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
