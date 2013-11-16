require 'spec_helper'

describe 'Visit to the pages' do
  let(:locale) { FactoryGirl.create :locale }

  context '#index' do
    it 'must be rendered' do
      get pages_path(:locale => locale.name)
      expect(response).to render_template(:index)
    end
  end

  context '#show' do
    let(:root_page) { FactoryGirl.create :content_page, :locale => locale, :name => locale.name, :state => 'on' }
    let(:some_page) { FactoryGirl.create :content_page, :locale => locale, :state => 'on' }

    it 'with valid page name must be rendered' do
      get page_path(:locale => locale.name, :name => some_page.name)
      expect(response).to render_template(:show)
    end

    it 'without params must be rendered with root template' do
      root_page
      get root_path(:locale => locale.name)
      expect(response).to render_template(:show)
    end

    it 'without valid page name must be rendered as 404' do
      get page_path(:locale => locale.name, :name => 'undefined_page')
      expect(response.status).to eq(404)
    end
  end
end
