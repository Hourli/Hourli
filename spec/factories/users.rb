FactoryGirl.define do
  factory :user do
    email "testing@hourli.com"
    password "myweakpassword"
    password_confirmation "myweakpassword"
  end
end
