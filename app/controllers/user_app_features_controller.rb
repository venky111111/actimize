class UserAppFeaturesController < ApplicationController
	def index
    if params[:user_app_id]
      @userApps = UserApp.includes(user_app_features: :user_app_sub_features)
                         .where(id: params[:user_app_id])

      render json: @userApps, each_serializer: UserAppFeatureSerializer, status: :ok
    else
      render json: { message: "User App ID is required" }, status: :unprocessable_entity
    end
  end
end
