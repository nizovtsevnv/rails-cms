FactoryGirl.define do
  factory :content_widget, :class => Content::Widget do
    association :locale
    sequence(:name) {|n| "widget#{n}"}
  end
end
