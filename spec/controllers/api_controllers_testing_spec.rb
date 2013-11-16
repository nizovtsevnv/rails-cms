require 'spec_helper'

describe '@data in' do
  {
    'api/activities' => {:factory => :activity, :routes => [:index, :show]},
    'api/content/pages' => {:factory => :content_page, :routes => [:create, :destroy, :index, :show, :update]},
    'api/content/uploads' => {:factory => :content_upload, :routes => [:create, :destroy, :index, :update]},
    'api/content/widgets' => {:factory => :content_widget, :routes => [:create, :destroy, :index, :show, :update]},
    'api/locales' => {:factory => :locale, :routes => [:create, :destroy, :index, :show, :update]},
    'api/users' => {:factory => :user, :routes => [:create, :destroy, :index, :show, :update]}
  }.each do |controller, options|
    describe "#{controller}_controller".camelize.safe_constantize do
      before(:each){ @object = FactoryGirl.create options[:factory] }
      options[:routes].each do |action|
        context "#{controller}\##{action} must be" do
        case action
        when :create
          it "#{options[:factory].to_s.camelize} object" do
            get :create
            expect(assigns(:data)).to eq(@object)
          end
        when :destroy
          it "true" do
            get :destroy, :id => @object.id
            expect(assigns(:data)).to be true
          end
        when :index
          it "an ActiveRecord::Relation object" do
            get :index
            expect(assigns(:data)).to eq([@object])
          end
        when :show
          it "#{options[:factory].to_s.camelize} object" do
            get :show, :id => @object.id
            expect(assigns(:data)).to eq(@object)
          end
        when :update
        end
        end
      end
    end
  end
end
