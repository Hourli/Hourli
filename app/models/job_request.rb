class JobRequest < ActiveRecord::Base
   	include Elasticsearch::Model
   	include Elasticsearch::Model::Callbacks
   	
	validates :title, :presence => true
	validates :description, :presence => true
	validates :location, :presence => true
	validates :hourly_rate, :presence => true
	validates :categories, :presence => true

	belongs_to :customer
    has_many :job_offers
    
    if Rails.env == 'test' 
        index_name("test_job_requests")
    else
        index_name("not-test_job_requests")
    end
end
