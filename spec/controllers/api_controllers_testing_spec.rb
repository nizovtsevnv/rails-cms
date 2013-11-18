require 'spec_helper'

describe 'Request to' do
  {
    'api/activities' => {:factory => :activity, :routes => [:index, :show]},
    'api/content/pages' => {:factory => :content_page, :routes => [:create, :destroy, :index, :show, :update]},
    'api/content/uploads' => {:factory => :content_upload, :routes => [:create, :destroy, :index, :update]},
    'api/content/widgets' => {:factory => :content_widget, :routes => [:create, :destroy, :index, :show, :update]},
    'api/locales' => {:factory => :locale, :id => :name, :routes => [:create, :destroy, :index, :show, :update]},
    'api/users' => {:factory => :user, :routes => [:create, :destroy, :index, :show, :update]}
  }.each do |controller, options|
    options[:id] ||= :id 
    describe "#{controller}_controller".camelize.safe_constantize || controller do
      before(:each){ @object = FactoryGirl.create options[:factory] }
      options[:routes].each do |action|
        context "\##{action} must" do
          case action

          # on the input: params hash[factory] = {attribute: value, ...}
          # on the output: @data = last persisted Object, @success = true
          when :create
            before(:each){
              values = FactoryGirl.attributes_for(options[:factory])
              post :create, options[:factory] => values
            }
            it "create record without errors in @data" do
              expect(assigns(:data).errors.messages).to eq({})
            end

            it "create record and define it to @data" do
              expect(assigns(:data)).to eq(@object.class.last)
            end

            it "define @success = true" do
              expect(assigns(:success)).to be true
            end

          # on the input: params hash[:id] = some_id
          # on the output: @success = true
          when :destroy
            it "define @success = true" do
              get :destroy, :id => @object[options[:id]]
              expect(assigns(:success)).to be true
            end

          # on the input: params hash with optional keys for sorting, filtering and pagination
          # on the output: @data = ActiveRecord::Relation(Object), @total = Object.count
          when :index
            it "define a list of model records in @data" do
              get :index
              expect(assigns(:data)).to eq([@object])
            end

            it "define count of model records in @total" do
              get :index
              expect(assigns(:total)).to be(@object.class.count)
            end

          # on the input: params hash[:id] = some_id
          # on the output: @data = Object
          when :show
            it "define selected model record in @data" do
              get :show, :id => @object[options[:id]]
              expect(assigns(:data)).to eq(@object)
            end

          # on the input: params hash with id and new values
          # on the output: @data = Object, @success = true
          when :update
            before(:each){
              new_values = FactoryGirl.attributes_for(options[:factory])
              post :update, :id => @object[options[:id]], options[:factory] => new_values
            }
            it "update attributes without errors in @data" do
              expect(assigns(:data).errors.messages).to eq({})
            end

            it "change attributes in selected model record" do
              expect(assigns(:data)).not_to be(@object)
            end

            it "save new attributes in selected model record" do
              expect(assigns(:data).changed?).to be false
            end

            it "define @success = true" do
              expect(assigns(:success)).to be true
            end
          end
        end
      end
    end
  end
end
