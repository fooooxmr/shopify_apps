require 'rails_helper'

describe AppsPage do

  describe '.all' do
    let!(:apps_page_1) { create :apps_page, created_at: '01-01-2017 10:00'  }
    let!(:apps_page_2) { create :apps_page, created_at: '01-01-2017 18:00'  }

    context 'with config' do
      before do
        ConfigService.set_config(analyse_every: 1, max_date: '01-01-2017 15:00')
      end


      it 'should return one apps page version' do
        expect(AppsPage.count).to eq(1)
      end
    end

    context 'with default config' do
      before do
        ConfigService.set_config({})
      end

      it 'should return two apps page version' do
        expect(AppsPage.count).to eq(2)
      end
    end
  end
end