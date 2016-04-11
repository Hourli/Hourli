class AddOngoingToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :ongoing, :boolean, default: true
  end
end
