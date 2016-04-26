class Job < ActiveRecord::Base
    
    include ActiveModel::Validations
    
    validates :name, :presence => true
    
    validates :description, :presence => true
    
    validates :location, :presence => true
    
    validates :start_date, :presence => true
    
    validates :end_date, :presence => true
    
    belongs_to :contractor
end
