Then(/^I should see "([^"]*)"$/) do |arg|
  expect(page.body).to have_content(arg)
end

When(/^I go to the "([^"]*)" page$/) do |page|
	visit(path_to(page))
end

And(/^I click on contact us link$/) do
	click_link("contact_us")
end

And(/^I click on about us link$/) do
	click_link("about_us")
end

Then(/^I am on the "([^"]*)" page$/) do |page|
	expect(current_path).to eq(path_to(page))
end

When (/^I fill in "([^"]*)" with "([^"]*)"$/) do |a1,a2|
	fill_in(a1, with: a2)
	
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When(/^I select "([^"]*)" from "([^"]*)"$/) do |arg1, arg2|
  select(arg1, from: arg2)
end