Given /^the following job exists:$/ do |table|
    table.hashes.each do |job|
      Job.create!(name: job[:name], description: job[:description], location: job[:location], start_date: job[:start_date], end_date: job[:end_date], contractor: @user.contractor)
  end
end

Then /^the job name should be "([^"]*)"$/ do |arg1|
  step %Q{I should see "#{arg1}"}
end

Then /^the job should be completed$/ do
expect(page).to have_css('.fa-check-square')
end

Then /^the job should not be completed$/ do
expect(page).to have_css('.fa-times')
end

Given /^the job named "([^"]*)" belongs to the current user's customer account$/ do |job_name|
  this_job = Job.find_by(name: job_name)
  this_job.customer = @user.customer
  this_job.save
end

Given /^the job named "([^"]*)" is completed$/ do |job_name|
  this_job = Job.find_by(name: job_name)
  this_job.completed = true
  this_job.save
end

And /^the job named "([^"]*)" should be under "([^"]*)"$/ do |job_name, tab_name|
  case tab_name
    when "Your Job Requests"
      assert_selector('#requests', text: job_name)
    when "Ongoing Jobs"
      assert_selector('#ongoing', text: job_name)
    when "Completed Jobs"
      assert_selector('#completed', text: job_name) 
  end
end