require 'sidekiq-scheduler'
require 'sidekiq'

class AnalyseWorker
  include Sidekiq::Worker

  def perform
    PageParserService.new.call
  end
end