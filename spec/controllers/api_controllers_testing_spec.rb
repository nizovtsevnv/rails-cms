require 'spec_helper'

describe '@data in' do
  {
    'api/activities' => {:factory => :activity, :routes => [:index, :show]},
    'api/content/pages' => {:factory => :content_page, :routes => [:create, :destroy, :index, :show, :update]},
    'api/content/uploads' => {:factory => :content_upload, :routes => [:create, :destroy, :index, :update]},
    'api/content/widgets' => {:factory => :content_widget, :routes => [:create, :destroy, :index, :show, :update]},
    'api/locales' => {:factory => :locale, :id => :name, :routes => [:create, :destroy, :index, :show, :update]},
    'api/users' => {:factory => :user, :routes => [:create, :destroy, :index, :show, :update]}
  }.each do |controller, options|
    options[:id] ||= :id 
    describe "#{controller}_controller".camelize.safe_constantize do
      before(:each){ @object = FactoryGirl.create options[:factory] }
      options[:routes].each do |action|
        context "#{controller}\##{action} must be" do
        case action
        when :create
          # on the input: params hash[factory] = {attribute: value, ...}
          # on the output: @data = last persisted Object, @success = true
          it "#{options[:factory].to_s.camelize} object and be succesful" do
            post :create, options[:factory] => FactoryGirl.attributes_for(options[:factory])
            expect(assigns(:data)).to eq(@object.class.last)
            expect(assigns(:success)).to be true
          end
        when :destroy
          # on the input: params hash[:id] = some_id
          # on the output: @success = true
          it "#{options[:factory].to_s.camelize} object and be succesful" do
            get :destroy, :id => @object[options[:id]]
            expect(assigns(:success)).to be true
          end
        when :index
          # on the input: params hash with optional keys for sorting, filtering and pagination
          # on the output: @data = ActiveRecord::Relation(Object), @total = Object.count
          it "an ActiveRecord::Relation object" do
            get :index
            expect(assigns(:data)).to eq([@object])
            expect(assigns(:total)).to eq(@object.class.count)
          end
        when :show
          # on the input: params hash[:id] = some_id
          # on the output: @data = Object
          it "#{options[:factory].to_s.camelize} object" do
            get :show, :id => @object[options[:id]]
            expect(assigns(:data)).to eq(@object)
          end
        when :update
          # on the input: params hash with id and new values
          # on the output: @data = Object, @success = true
          it "#{options[:factory].to_s.camelize} object and be succesful" do
            post :update, :id => @object[options[:id]], options[:factory] => FactoryGirl.attributes_for(options[:factory])
            expect(assigns(:data)).to eq(@object)
            expect(assigns(:success)).to be true
          end
        end
        end
      end
    end
  end
end
