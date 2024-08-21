class UserApp < ApplicationRecord
	has_many :user_app_features
	serialize :app_platform, Array
	has_many :user_app_documents

end
