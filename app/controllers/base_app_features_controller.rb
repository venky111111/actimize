class BaseAppFeaturesController < ApplicationController
	def index
	    if params[:base_app_id]
	      @baseApps = BaseApp.includes(:base_app_features => :base_app_sub_features)
	                         .where(id: params[:base_app_id])


	          render json: @baseApps, status: :ok
	    else
      	render json: { message: "User App ID is required" }, status: :unprocessable_entity
    	end   
	  end
	def show
	end
end
