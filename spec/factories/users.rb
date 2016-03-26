FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    role "customer"
    email "testing@hourli.com"
    password "myweakpassword"
    password_confirmation "myweakpassword"
  end
end
