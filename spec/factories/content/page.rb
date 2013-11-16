FactoryGirl.define do
  factory :content_page, :class => Content::Page do
    association :locale
    sequence(:name) {|n| "page#{n}"}
    state 'on'
  end
end
