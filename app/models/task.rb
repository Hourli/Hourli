class Task < ActiveRecord::Base
  belongs_to :job
  validates :title, presence: true
end
