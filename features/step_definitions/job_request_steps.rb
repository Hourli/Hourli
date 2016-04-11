Given /^the following job requests exist:$/ do |table|
    table.hashes.each do |job_request|
    JobRequest.create(title: job_request[:title], description: job_request[:description], location: job_request[:location ], hourly_rate: job_request[:hourly_rate], categories: job_request[:categories])
  end
end