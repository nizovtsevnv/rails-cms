include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :content_upload, :class => Content::Upload do
    attachment {fixture_file_upload("#{Rails.root}/spec/attachments/attachment.txt")}
    sequence(:name) {|n| "File #{n}"}    
  end
end
