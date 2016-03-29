class JobRequest < ActiveRecord::Base
   
	validates :title, :presence => true
	validates :description, :presence => true
	validates :location, :presence => true
	validates :hourly_rate, :presence => true
	validates :categories, :presence => true

	belongs_to :customer
	
end
