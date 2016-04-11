Given /the user with email "([^"]*)" has a contractor account/ do |email|
    User.find_by_email(email).contractor = Contractor.create()
end