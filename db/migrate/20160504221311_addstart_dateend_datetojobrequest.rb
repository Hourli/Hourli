class AddstartDateendDatetojobrequest < ActiveRecord::Migration
  def change
  	add_column :job_requests, :start_date, :date
  	add_column :job_requests, :end_date, :date
  end
end
