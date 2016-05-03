class Contractor < ActiveRecord::Base
    belongs_to :user
    has_many :jobs
    has_many :job_offers
end
