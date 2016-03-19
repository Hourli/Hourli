Then(/^I should see "([^"]*)"$/) do |arg|
  expect(page.body).to have_content(arg)
end
