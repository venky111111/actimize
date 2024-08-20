class BaseAppsController < ApplicationController

	def index
    @baseApps = BaseApp.includes(:base_app_features => :base_app_sub_features).all

    base_apps_with_features = @baseApps.map do |base_app|
      {
        id: base_app.id,
        name: base_app.name,
        logo: base_app.logo,
        theme_color: base_app.theme_color,
        app_platform: base_app.app_platform,
        design: base_app.design,
        basic_build: base_app.basic_build,
        full_build: base_app.full_build,
        note: base_app.note,
        budget: base_app.budget,
        payment_way: base_app.payment_way,
        support: base_app.support,
        cloud: base_app.cloud,
        market_place: base_app.market_place,
        features_count: base_app.base_app_features.all.count,
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

    render json: { base_apps: base_apps_with_features }, status: :ok
  end
  # def index
  #   @baseApps = BaseApp.includes(:base_app_features => :base_app_sub_features).all

  #   base_apps_with_features = @baseApps.map do |base_app|
  #     {
  #       id: base_app.id,
  #       name: base_app.name,
  #       logo: base_app.logo,
  #       theme_color: base_app.theme_color,
  #       app_platform: base_app.app_platform,
  #       design: base_app.design,
  #       basic_build: base_app.basic_build,
  #       full_build: base_app.full_build,
  #       note: base_app.note,
  #       budget: base_app.budget,
  #       payment_way: base_app.payment_way,
  #       support: base_app.support,
  #       cloud: base_app.cloud,
  #       market_place: base_app.market_place,
  #       features_count: base_app.base_app_features.all.count, 
  #       description: base_app.description
  #     }
  #   end

  #   render json: { base_apps: base_apps_with_features }, status: :ok
  # end

end
