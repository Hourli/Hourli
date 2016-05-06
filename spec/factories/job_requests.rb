FactoryGirl.define do
  factory :job_request do
    title "Mow my lawn"
    description "This is a random paragraph. doot dee doot dee doot dee doot. This is a sentence. I am writing multiple sentences."
    location "123 Fake Street"
    hourly_rate 15.50
    start_date "2016-03-22"
    end_date "2016-03-22"
    categories "Landscaping manual labor"
    customer_id 1
  end
end

