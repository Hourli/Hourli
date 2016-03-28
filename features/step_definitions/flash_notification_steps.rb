Given(/^An? "([^"]*)" flash message exists$/) do |msg_type|
  step %Q{I have a confirmed "customer" account}
  if msg_type == "alert"
    step %Q{I login with an invalid "email"}
  else
    step %Q{I login with valid credentials}
    visit(edit_user_registration_path)
  end

end

When(/^I reload the page for "([^"]*)"$/) do |msg_type|
  if msg_type == "alert"
    # This will trigger a page reload with invalid login credentials
    click_on("login_navbar")
  else
    fill_in("user[current_password]", with: @user.password)
    click_on("Update")
  end
end

Then(/^I should see an? "([^"]*)" message in the top right corner of my screen$/) do |msg_type|
  if msg_type == "alert"
    expect(page.body).to have_content("Invalid email or password.")
  else
    expect(page.body).to have_content("Your account has been updated successfully.")
  end
end
