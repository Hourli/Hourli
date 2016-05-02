class Customer < ActiveRecord::Base
    belongs_to :user
    has_many :job_requests

    # This association is here to link customers to their ongoing/completed
    # jobs.  When job offer is accepted, the job will be created with
    # customer_id = current_user.customer.id
    # contractor_id = contractor who made the job offer
    has_many :jobs
end
