FactoryGirl.define do
  factory :locale do
    sequence(:name) {|n| "locale#{n}"}
  end
end
