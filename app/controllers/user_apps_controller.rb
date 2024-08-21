class UserAppsController < ApplicationController
def index
    @userApps = UserApp.includes(:user_app_features => :user_app_sub_features).all

    user_apps_with_features = @userApps.map do |user_app|
      {
        id: user_app.id,
        application_name: user_app.application_name,
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
        user_name: user_app.user_name,
        description: user_app.description,
        documents: user_app.user_app_documents.all,
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

    render json: user_apps_with_features , status: :ok
  
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

def show
   
      user_app = UserApp.includes(user_app_features: :user_app_sub_features).find(params[:id])
      render json: user_app, status: :ok
  
    
 end

def create
  @userApp = UserApp.new(user_app_params)

  if @userApp.save
    base_app = BaseApp.find(params[:base_app])
    base_app.base_app_features.each do |feature|
      user_app_feature = UserAppFeature.create(name: feature.name, user_app_id: @userApp.id)
      feature.base_app_sub_features.each do |subfeature|
        user_app_sub_feature = UserAppSubFeature.create(
          name: subfeature.name,
          user_app_feature_id: user_app_feature.id,
          description: subfeature.description,
          selected: true
        )
      end
    end
    base_app.base_app_documents.each do |doc|
    	user_app_docs = UserAppDocument.create(user_app_file_name: doc.base_app_file_name, user_app_file_type: doc.base_app_file_type, user_app_file_data: doc.base_app_file_data, user_app_id: @userApp.id )
    end

    render json: { message: "UserApp created successfully",  userAppData: @userApp }, status: :ok
  else
    render json: { message: 'Failed to create the UserApp', errors: @userApp.errors.full_messages }, status: :unprocessable_entity
  end
end


	def update
		@userAppstep2 = UserApp.find(params[:id])

		if params[:step] == '2'
			if @userAppstep2 

				if @userAppstep2.update(application_name: params[:application_name], logo: params[:logo], theme_color: params[:theme_color], step: params[:step] )
						render json: @userAppstep2, status: :ok
				else
					 render json: { errors: @userAppstep2.errors.full_messages }, status: :unprocessable_entity
				end

			end

		end

		if params[:step] == '3'
			features_data = params[:features]
      features_data.each do |feature_data|
        feature = @userAppstep2.user_app_features.find(feature_data[:feature_id])
        new_subfeature_ids = feature_data[:sub_feature_ids]
        feature.user_app_sub_features.map do |subfeature|
        	feature.user_app_sub_features.find(subfeature.id).update(selected: true)
        end
        feature.user_app_sub_features.where.not(id: new_subfeature_ids).map do |subfeature|
        	feature.user_app_sub_features.find(subfeature.id).update(selected: false)
        end
      end
			render json: @userAppstep2, status: :ok
		end

		if params[:step] == '4'
			if @userAppstep2

				if @userAppstep2.update(app_platform: params[:app_platforms], design: params[:app_designs], basic_build: params[:basic_build], full_build: params[:full_build] )
						render json: @userAppstep2, status: :ok
				else
					 render json: { errors: @userAppstep2.errors.full_messages }, status: :unprocessable_entity
				end

			end

		end
		if params[:step] == '5'
		  if @userAppstep2
		    documents_data = params[:documents]
		    existing_document_ids = @userAppstep2.user_app_documents.pluck(:id)
		    provided_document_ids = documents_data.map { |doc| doc[:id] }
		    documents_to_delete = existing_document_ids - provided_document_ids
		    @userAppstep2.user_app_documents.where(id: documents_to_delete).destroy_all
		    documents_data.each do |doc_params|
		      if doc_params[:id].zero?
		        @userAppstep2.user_app_documents.create(
		          user_app_file_name: doc_params[:user_app_file_name],
		          user_app_file_type: doc_params[:user_app_file_type],
		          user_app_file_data: doc_params[:user_app_file_data],
		          user_app_id: @userAppstep2.id
		        )
		    	end
		  	end

		  	if params[:note]
		  		@userAppstep2.update(note: params[:note])
		  	end

			end
			render json: @userAppstep2.user_app_documents, status: :ok
		end

		if params[:step] == '6'
			if @userAppstep2

				if @userAppstep2.update(payment_way: params[:application_budget], budget: params[:application_payment_way] )
						render json: @userAppstep2, status: :ok
				else
					 render json: { errors: @userAppstep2.errors.full_messages }, status: :unprocessable_entity
				end

			end

		end
	
		if params[:step] == '7'
			if @userAppstep2

				if @userAppstep2.update(support: params[:actimize_support], cloud: params[:actimize_cloud], market_place: params[:market_place])
						render json: @userAppstep2, status: :ok
				else
					 render json: { errors: @userAppstep2.errors.full_messages }, status: :unprocessable_entity
				end

			end
		end
		if params[:step] == '8'
			if @userAppstep2 
				if @userAppstep2.update(coupon_code: params[:coupon_code])
					render json: @userAppstep2, status: :ok
				
				else
				render json: { errors: @userAppstep2.errors.full_messages }, status: :unprocessable_entity
				end
			end
		end

	end
	private

	def user_app_params
		params.permit(:user_name, :user_role, :user_email, :user_phone, :base_app, :step)
	end
end
