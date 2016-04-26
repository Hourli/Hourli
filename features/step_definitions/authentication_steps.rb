def create_unconfirmed_user_account(role='customer')
  @user = FactoryGirl.create(:user, role: role)
end

def create_confirmed_user_account(role='customer')
  create_unconfirmed_user_account(role)
  # confirm_user_account
end

def confirm_user_account
  # confirmation_email =  ActionMailer::Base.deliveries.last
  # confirmation_link = confirmation_email.body.raw_source.scan(/href="([^"]*)"/).join("")
  # visit(confirmation_link)

  @user.confirmed_at = Time.now
  @user.save!
end

def destroy_user_account
  user ||= User.where(email: @user.email)
  User.delete(user) unless user.nil?
end

# Assumes logging in via login page, not the login in the navbar
def login(email='', password='')
  visit(new_user_session_path)
  fill_in("user_email", with: email.empty? ? @user.email : email)
  fill_in("user_password", with: password.empty? ? @user.password : password)
  click_on("login_main")
end

def logout
  visit(destroy_user_session_path)
end

Given(/^I am logged in$/)do
  create_confirmed_user_account
  login
end

Given(/^I login with valid credentials$/) do
  login
end

Given(/^I login with an invalid "([^"]*)"$/) do |invalid_field|
  if invalid_field == "email"
    login(email="myinvalidemail@hourli.com")
  else
    login(password="myinvalidpassword")
  end
end

Given(/^I am not logged in$/) do
  logout
end

When(/^I logout$/) do
  # click_on("Account")
  # click_on("Logout")
  logout
end

Given(/^I have a confirmed "([^"]*)" account$/) do |role|
  create_confirmed_user_account(role)
end

Given(/^I have an unconfirmed account$/) do
  create_unconfirmed_user_account
end

Then(/^I should be logged in$/) do
  expect(page.body).to have_content("Logout")
  expect(page.body).not_to have_content("Login")
  expect(page.body).not_to have_content("Signup")
end

Then(/^I should not be logged in$/) do
  expect(page.body).not_to have_content("Logout")
end

Then(/^I should be both a customer and a contractor$/) do
  expect(@user.contractor).not_to be_nil
  expect(@user.customer).not_to be_nil
end
