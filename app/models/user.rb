class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :first_name, :last_name, :role, presence: true

  has_one :customer
  has_one :contractor
  has_many :notifications
  
  after_create :create_customer_contractor_or_both
  
  private
  
  def create_customer_contractor_or_both
    case self.role
      when "customer"
        self.customer = Customer.create()
        self.save
      when "contractor"
        self.contractor = Contractor.create()
        self.save
      when "both"
        self.customer = Customer.create()
        self.contractor = Contractor.create()
        # In this case default to customer role
        self.role = "customer"
        self.save
      else
        # Just default to a customer 
        self.customer = Customer.create()
        self.role = "customer"
        self.save
      end
    end
end
