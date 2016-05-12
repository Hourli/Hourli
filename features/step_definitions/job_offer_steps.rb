Given /^the following job offers for job request "(.*)" exist:$/ do |title, table|
  table.hashes.each do |job_offer|
    JobOffer.create(title: job_offer[:title], description: job_offer[:description], hourly_rate: job_offer[:hourly_rate], contractor: @other_user.contractor, job_request: JobRequest.find_by_title(title))
    #JobRequest.find_by_title(title)
    #puts"&&&&&&&&&&&&&&&&&&"
    #a.customer_id=1
    #puts a.job_request.job_offer
    #a.save
  end
end
