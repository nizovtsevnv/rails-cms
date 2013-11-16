FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@my.srv"}
    password 'password'
  end
end
