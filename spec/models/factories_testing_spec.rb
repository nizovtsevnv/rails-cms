require 'spec_helper'

describe 'Creating by factory' do
  Dir.glob('spec/factories/**/*.rb').each do |file|
    filename = file.sub(/\Aspec\/factories\//, '').sub(/\.rb$/, '')
    model = filename.camelize.constantize
    factory = filename.gsub(/\//, '_')
    if model.class != Module
      it ":#{factory} must be successful" do
        item = FactoryGirl.create factory
        item.persisted?
      end

      it ":#{factory} on second record must be successful" do
        item = FactoryGirl.create factory
        item.persisted?
      end
    end
  end
end
