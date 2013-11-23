require 'spec_helper'

describe 'Visit to the cms' do
  context '#show' do
    before{
      get cms_path
    }

    it 'must render application template' do
      expect(response).to render_template(:application)
    end
  end
end
