class JobOffer < ActiveRecord::Base

    validates :title, :presence => true
    validates :description, :presence => true
    validates :hourly_rate, :presence => true


    belongs_to :contractor
    belongs_to :job_request
end
