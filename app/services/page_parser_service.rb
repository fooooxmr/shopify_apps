require 'open-uri'

class PageParserService
  attr_reader :doc

  SHOPIFY_URL = 'https://apps.shopify.com/'.freeze

  CSS_PATHS = [
    BANNER = 'ul.app-icon-grid li > a'.freeze,
    NEWEST = 'ul.slideshow-selectors li a'.freeze
  ].freeze

  def initialize
    @doc = Nokogiri::HTML(open(SHOPIFY_URL))
  end

  def call
    AppsPage.create(page_state: all_apps.to_json, created_at: Time.zone.now)
  end

  private

  def all_apps
    CSS_PATHS.map do |css|
      doc.css(css).map.with_index do |link, index|
        app_info(link).merge(position: index + 1)
      end
    end.flatten + categorized_apps
  end

  def categorized_apps
    doc.css('div.descriptive-app-group').map do |category|
      category.css('div.descriptive-app-group-grid li a').map.with_index do |link, index|
        app_info(link).merge(position: index + 1)
      end
    end.flatten
  end

  def app_info(link)
    {
      url: SHOPIFY_URL + link['href'],
      name: link_label(link),
      category: link['data-source']
    }
  end

  def link_label(link)
    JSON.parse(link['data-track-click'])['label']
  end
end