class BaseAppsController < ApplicationController
	 def index
    @baseApps = BaseApp.includes(:base_app_documents).all
        render json: @baseApps, status: :ok
  end
end
