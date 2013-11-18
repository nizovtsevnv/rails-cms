require 'spec_helper'

describe 'Visit to the cms' do
  context '#show' do
    before{
      get cms_path
    }

    it 'must render show template' do
      expect(response).to render_template(:show)
    end
  end
end
