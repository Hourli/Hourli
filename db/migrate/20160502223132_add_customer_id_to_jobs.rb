class AddCustomerIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :customer_id, :integer
  end
end
