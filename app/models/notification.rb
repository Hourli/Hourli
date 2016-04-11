class Notification < ActiveRecord::Base
  belongs_to :user
  validates :message, :user, presence: true
  validates :notification_for, presence: true, format: {with: /\A(customer|contractor)\z/, message: "is invalid, choose from 'customer' or 'contractor'"}
end
