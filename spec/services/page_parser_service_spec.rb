require 'rails_helper'
require 'vcr'

describe PageParserService do

  describe '.call' do
    let(:page_parser_service) { described_class.new }

    before do

      page_parser_service.call
      ConfigService.set_config({})
    end

    it 'should create page state from Shppify apps page', vcr: true do
      expect(AppsPage.count).to eq(1)
    end
  end
end