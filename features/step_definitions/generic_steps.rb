Then(/^I should see "([^"]*)"$/) do |arg|
  expect(page.body).to have_content(arg)
end

When(/^I go to the "([^"]*)" page$/) do |page|
	visit(path_to(page))
end

And(/^I click on contact us link$/) do
	click_link("contact_us")
end

Then(/^I am on the "([^"]*)" page$/) do |page|
	puts(current_path)
	expect(current_path).to eq(path_to(page))
end