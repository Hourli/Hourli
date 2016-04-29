Given(/^the following tasks exist:$/) do |table|
  table.hashes.each do |task|
    FactoryGirl.create(:task, title: task[:title], description: task[:description], completed: task[:completed], duration: task[:duration], job_id: task[:job_id])
  end
end
