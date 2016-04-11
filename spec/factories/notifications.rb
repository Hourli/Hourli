FactoryGirl.define do
  factory :notification do
    sequence(:message) { |n| "notification_#{n}"}
    notification_for 'customer'
    read false
    user nil
  end
end
