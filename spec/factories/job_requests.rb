FactoryGirl.define do
  factory :job_request do
    title "Mow my lawn"
    description "This is a random paragraph. doot dee doot dee doot dee doot. This is a sentence. I am writing multiple sentences."
    location "123 Fake Street"
    hourly_rate 15.50
    categories "Landscaping manual labor"
    #customer_id 10
  end
end

