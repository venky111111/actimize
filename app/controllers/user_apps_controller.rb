class UserAppsController < ApplicationController
def index
    @userApps = UserApp.includes(:user_app_features => :user_app_sub_features).all

    user_apps_with_features = @userApps.map do |user_app|
      {
        id: user_app.id,
        name: user_app.name,
        logo: user_app.logo,
        theme_color: user_app.theme_color,
        app_platform: user_app.app_platform,
        design: user_app.design,
        basic_build: user_app.basic_build,
        full_build: user_app.full_build,
        note: user_app.note,
        budget: user_app.budget,
        payment_way: user_app.payment_way,
        support: user_app.support,
        cloud: user_app.cloud,
        market_place: user_app.market_place,
        app_id: user_app.app_id,
        user_name: user_app.user_name,
        description: user_app.description,
        features_count: user_app.user_app_features.all.count,
        features: user_app.user_app_features.map do |feature|
          {
            id: feature.id,
            name: feature.name,
            subfeatures: feature.user_app_sub_features.map do |subfeature|
              {
                id: subfeature.id,
                name: subfeature.name
              }
            end
          }
        end
      }
    end

    render json: { user_apps: user_apps_with_features }, status: :ok
  
end

	# def create
		
	# 	@userApp = UserApp.create(user_app_params)
	# 	if @userApp.save

	# 		@app_feature = BaseApp.find(:app_id).base_app_features

	# 		if @app_feature 

	# 			@app_feature.map do |feature|
	# 				@feature = UserAppFeature.create(name: feature.name, user_app_id: @userApp.id)
	# 				feature.base_app_sub_features.map do |subfeature|
	# 					@user_app_sub_feature = UserAppSubFeature.create(name: subfeature.name, user_app_feature_id: @feature.id, description: subfeature.description, selected: true);
	# 				end
	# 			end

	# 		end

	# 		render json: { message: 'UserApp Created successfully', userAppData: @userApp }, status: :ok
  #     else
  #       render json: { message: 'Failed to create the UserApp', errors: @userApp.errors.full_messages }, status: :unprocessable_entity
  #     end
	# end
	def create
  @userApp = UserApp.new(user_app_params)

  if @userApp.save
    base_app = BaseApp.find(params[:app_id])

    created_features = []
    base_app.base_app_features.each do |feature|
      user_app_feature = UserAppFeature.create(name: feature.name, user_app_id: @userApp.id)

      created_sub_features = []

      feature.base_app_sub_features.each do |subfeature|
        user_app_sub_feature = UserAppSubFeature.create(
          name: subfeature.name,
          user_app_feature_id: user_app_feature.id,
          description: subfeature.description,
          selected: true
        )
        created_sub_features << {
          id: user_app_sub_feature.id,
          name: user_app_sub_feature.name,
          description: user_app_sub_feature.description,
          selected: user_app_sub_feature.selected
        }
      end

      created_features << {
        id: user_app_feature.id,
        name: user_app_feature.name,
        sub_features: created_sub_features
      }
    end

    render json: { message: "UserApp created successfully",  userAppData: @userApp }, status: :ok
  else
    render json: { message: 'Failed to create the UserApp', errors: @userApp.errors.full_messages }, status: :unprocessable_entity
  end
end


	def update
		
		if params[:stage] == '2'

			@userAppstep2 = UserApp.find(params[:id])

			if @userAppstep2 

				if @userAppstep2.update(name: params[:name], logo: params[:logo], theme_color: params[:theme_color], stage: params[:stage] )
						render json: @userAppstep2, status: :ok
				else
					 render json: { errors: @userAppstep2.errors.full_messages }, status: :unprocessable_entity
				end

			end

		end

		if params[:stage] == '3'
			binding.pry
		end

		if params[:stage] == '4'
		end

	end
	private

	def user_app_params
		params.permit(:user_name, :user_role, :user_email, :user_phone, :app_id, :user_type, :stage)
	end
end
