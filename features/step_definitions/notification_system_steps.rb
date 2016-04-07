def create_notifications(count, read_or_unread)
  count = count.to_i
  count.times { |i|
    FactoryGirl.create(:notification, user: @user, message: "notification_#{i+1}", notification_for: 'customer', read: (read_or_unread == 'read') ? true : false)
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


And(/^"([^"]*)" should be an? (un)?read message$/) do |arg1, arg2|
  element = page.find(:id, arg1)
  if arg2 == 'un'
    expect(element).to have_text('customer'.capitalize)
    expect(element[:class]).not_to eq('list-group-item read-message')
  else
    expect(element).to have_text('customer'.capitalize)
    expect(element[:class]).to eq('list-group-item read-message')
  end
end


And(/^I should see "([^"]*)" in "([^"]*)"/) do |arg1, arg2|
  element = find(:id, arg2)
  expect(element).to have_text(arg1)
end
