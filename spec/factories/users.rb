FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    role "customer"
    email "testing@hourli.com"
    password "myweakpassword"
    password_confirmation "myweakpassword"
  end

  factory :contractor_user, :class => User do
    first_name "John"
    last_name "Doe"
    role "contractor"
    email "testing@hourli.com"
    password "myweakpassword"
    password_confirmation "myweakpassword"
  end

  factory :customer_user, :class => User do
    first_name "John"
    last_name "Doe"
    role "customer"
    email "testing@hourli.com"
    password "myweakpassword"
    password_confirmation "myweakpassword"
  end

end
