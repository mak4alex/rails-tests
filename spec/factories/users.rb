FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@mail.com" }
    password "password"
    password_confirmation "password"
  end
end
