class ConfigService
  class << self

    def set_config(config)
      $redis.SET 'config', config.to_json
      Sidekiq.set_schedule(:perform,
                           every: ["#{config[:analyse_every] ||
                               default_params[:analyse_every]}m"],
                           class: AnalyseWorker)
    end

    def get_config
      config_params = JSON.parse($redis.GET('config') || {}.to_s).symbolize_keys
      config_params.empty? ? Config.new(default_params) : Config.new(config_params)
    end

    private


    def default_params
      { analyse_every: 60, max_date: (DateTime.now + 1.day).to_s }
    end
  end
end