class UserAppFeaturesController < ApplicationController
	def index
	    if params[:user_app_id]
	      @userApps = UserApp.includes(:user_app_features => :user_app_sub_features)
	                         .where(id: params[:user_app_id])


	    user_apps_with_features = @userApps.map do |user_app|
	      {
	        id: user_app.id,
	        description: user_app.description,
	        
	        features: user_app.user_app_features.map do |feature|
	         {

            id: feature.id,
            features_count: feature.user_app_sub_features.count,
            name: feature.name,
            subfeatures: feature.user_app_sub_features.map do |subfeature|
              {
                id: subfeature.id,
                 name: subfeature.name,
                description: subfeature.description, 
                selected: subfeature.selected
             }
            end
          }
	        end
	      }
	    end

	    render json: { user_app: user_apps_with_features }, status: :ok
	    
	    end

	    
	  end
end
