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