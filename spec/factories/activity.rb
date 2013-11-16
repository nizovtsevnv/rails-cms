FactoryGirl.define do
  factory :activity do
    action 'action'
    association :user, :factory => :user
    controller 'controller'
    ip 'ip'
    host 'host'
  end
end
