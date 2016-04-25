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