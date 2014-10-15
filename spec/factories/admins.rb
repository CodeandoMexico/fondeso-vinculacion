FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@codeandomexico.org" }
    password "password"
    password_confirmation "password"
  end
end
