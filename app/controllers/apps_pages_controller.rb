class AppsPagesController < ApplicationController
  include AppsPagesHelper

  def index
    if params[:version]
      app_page = AppsPage.find_by(id: params[:version])
    else
      app_page= AppsPage.last
    end
    @apps_categories =  parse_json(app_page)
    @versions = AppsPage.all || []
  end
end