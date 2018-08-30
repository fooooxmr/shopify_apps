require 'rails_helper'

describe ConfigService do

  describe '.set_config' do
    before do
      described_class.set_config({})
    end

    it 'config must return default values' do
      expect(described_class.get_config).to be_instance_of(Config)
    end

    it 'analyse worker should receive call' do
      allow_any_instance_of(PageParserService).to receive(:call)
    end
  end

  describe '.get_config' do
    let(:config) { described_class.get_config }

    before do
      described_class.set_config(analyse_every: 1, max_date: '01-01-2017 15:00')
    end

    it 'should return config' do
      expect(config).to be_instance_of(Config)
      expect(config.analyse_every).to eq(1)
      expect(config.max_date).to eq('01-01-2017 15:00')
    end
  end
end