User.create(:email => 'admin@my.srv', :password => 'password')

Locale.where(:name => 'en', :title => 'English').first_or_create
Locale.where(:name => 'ru', :title => 'Русский').first_or_create

Content::Page.create(:locale_name => 'en', :name => 'en', :body => 'Hello world!', :state => 'on')
Content::Page.create(:locale_name => 'ru', :name => 'ru', :body => 'Привет мир!', :state => 'on')

Content::Widget.create(:locale_name => 'en', :name => 'description', :body => 'Hello world!')
Content::Widget.create(:locale_name => 'ru', :name => 'description', :body => 'Привет мир!')

Content::Widget.create(:locale_name => 'en', :name => 'title', :body => 'Hello world!')
Content::Widget.create(:locale_name => 'ru', :name => 'title', :body => 'Привет мир!')

Content::Widget.create(:locale_name => 'en', :name => 'keywords', :body => 'Hello world!')
Content::Widget.create(:locale_name => 'ru', :name => 'keywords', :body => 'Привет мир!')
