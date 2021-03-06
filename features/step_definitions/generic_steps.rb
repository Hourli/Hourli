def wait_for_ajax
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end
end

Then(/^I should see "([^"]*)"$/) do |arg|
  expect(page.body).to have_content(arg)
end

Then(/^I should not see "([^"]*)"$/) do |arg|
  expect(page.body).not_to have_content(arg)
end

When(/^I go to the "([^"]*)" page$/) do |page|
  visit(path_to(page))
end

When(/^I check "([^"]*)"$/) do |element|
  check(element)
end

When(/^I uncheck "([^"]*)"$/) do |element|
  uncheck(element)
end

And(/^I click on contact us link$/) do
  click_link("contact_us")
end

And(/^I click on about us link$/) do
  click_link("about_us")
end

And(/^I click on "([^"]*)" link$/) do |link|
  click_link(link)
end

Then(/^I am on the "([^"]*)" page$/) do |page|
  expect(current_path).to eq(path_to(page))
end

When (/^I fill in "([^"]*)" with "([^"]*)"$/) do |a1, a2|
  fill_in(a1, with: a2)
end

When (/^(?:|I )press "([^"]*)"$/) do |button|
  #puts(page.body)
  click_on(button)
end

Then (/^I should see a "([^"]*)" button$/) do |button|
  expect(page.body).to have_button(button)
end

When(/^I select "([^"]*)" from "([^"]*)"$/) do |arg1, arg2|
  select(arg1, from: arg2)
end

And(/^I wait for ajax after pressing "([^"]*)"$/) do |arg|
  click_on(arg)
  wait_for_ajax
end
