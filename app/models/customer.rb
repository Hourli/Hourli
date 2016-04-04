class Customer < ActiveRecord::Base
    belongs_to :user
    has_many :job_requests
end
