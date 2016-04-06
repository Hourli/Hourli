def create_notifications(count, read_or_unread)
  count = count.to_i
  count.times {
    FactoryGirl.create(:notification, user: @user, read: (read_or_unread == 'read') ? true : false)
  }
end

Given(/^I have "([^"]*)" "([^"]*)" notifications$/) do |arg1, arg2|
  create_notifications(arg1, arg2)
end

Then(/^The notification bell should display "([^"]*)"$/) do |arg|
  wait_for_ajax
  expect(find('#notification_badge')).to have_content(arg)
end

When(/^I create "([^"]*)" notifications?$/) do |arg|
  step %Q{I have "#{arg}" "unread" notifications}
end

And(/^The browser polls for new notifications$/) do
  wait_for_ajax
end
