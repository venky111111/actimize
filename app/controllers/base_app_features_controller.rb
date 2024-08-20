class BaseAppFeaturesController < ApplicationController
	def index
	    if params[:base_app_id]
	      @baseApps = BaseApp.includes(:base_app_features => :base_app_sub_features)
	                         .where(id: params[:base_app_id])


	    base_apps_with_features = @baseApps.map do |base_app|
	      {
	        id: base_app.id,
	        description: base_app.description,
	        
	        features: base_app.base_app_features.map do |feature|
	         {

            id: feature.id,
            features_count: feature.base_app_sub_features.count,
            name: feature.name,
            subfeatures: feature.base_app_sub_features.map do |subfeature|
              {
                id: subfeature.id,
                 name: subfeature.name,
                 	description: subfeature.description
             }
            end
          }
	        end
	      }
	    end

	    render json: { base_app: base_apps_with_features }, status: :ok
	    
	    end

	    
	  end
	def show
	end
end
