And(/^I am currently viewing as a "([^"]*)"$/) do |arg|
  @user.role = arg
  @user.save!
end
