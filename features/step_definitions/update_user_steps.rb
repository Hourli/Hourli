
# Assumes logging in via login page, not the login in the navbar
def login_with(email='', password='')
  visit(new_user_session_path)
  fill_in("user_email", with: email)
  fill_in("user_password", with: password)
  click_on("login_main")
end

Given /^the following user exists:$/ do |table|
  table.hashes.each do |user|
    user = User.new(first_name: user[:first_name], last_name: user[:last_name], 
                          email: user[:email], password: user[:password], role: user[:role])
    user.skip_confirmation!
    user.save
  end
end

Given /^I am logged in with email "([^"]*)" and password "([^"]*)"/ do |email,password|
  login_with(email, password)
  expect(page.body).to have_content('Signed in successfully.')
end
