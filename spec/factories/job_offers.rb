FactoryGirl.define do
  factory :job_offer do
    title "Mow my lawn"
    description "This is a random paragraph. doot dee doot dee doot dee doot. This is a sentence. I am writing multiple sentences."
    hourly_rate 15.50
    contractor_id 1
    job_request_id 1
  end
end
