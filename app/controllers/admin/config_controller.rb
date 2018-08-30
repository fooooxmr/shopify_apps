module Admin
  class ConfigController < ApplicationController

    def edit
      @config = ConfigService.get_config
    end

    def update
      @config = Config.new(permited_params)
      if @config.valid?
        ConfigService.set_config(permited_params)
        redirect_to :root
      else
        render :edit
      end
    end

    private

    def permited_params
      params.require(:config).permit(:analyse_every, :max_date).to_h.symbolize_keys
    end
  end
end